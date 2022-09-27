import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:sumry_man/utils/extensions.dart';

import '../../data/repository/summary_repository.dart';

final _lines = StateProvider.autoDispose<int>((ref) => 1);
final _selectedIndex = StateProvider.autoDispose<int>((ref) => 0);
final _document = StateProvider.autoDispose<PlatformFile?>((ref) => null);
final _isLoading = StateProvider.autoDispose<bool>((ref) => false);

final homeState = Provider.autoDispose((ref) {
  return HomeState(
    ref.watch(_lines),
    ref.watch(_selectedIndex),
    ref.watch(_document),
    ref.watch(_isLoading),
  );
});

class HomeState {
  final int lines, selectedIndex;
  final PlatformFile? document;
  final bool isLoading;

  const HomeState(
    this.lines,
    this.selectedIndex,
    this.document,
    this.isLoading,
  );

  void copyToClipboard(String text, BuildContext context) async {
    Clipboard.setData(ClipboardData(text: text)).then((value) {
      context.showSnackMessage(
        text.isEmpty ? 'Nothing to copy' : 'Copied to clipboard',
      );
    });
  }

  selectText(WidgetRef ref) {
    ref.read(_selectedIndex.notifier).state = 1;
  }

  selectFile(WidgetRef ref) async {
    ref.read(_selectedIndex.notifier).state = 2;
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt', 'docx'],
    );

    if (result != null) {
      ref.read(_document.notifier).state = result.files.first;
    }
  }

  updateLines(WidgetRef ref, int lines) {
    ref.read(_lines.notifier).state = lines;
  }

  clearInput(
    TextEditingController controller,
    BuildContext context,
    WidgetRef ref,
  ) {
    controller.clear();
    ref.read(_document.notifier).state = null;
    ref.read(_selectedIndex.notifier).state = 0;
    FocusScope.of(context).unfocus();
  }

  summarize(
    TextEditingController text,
    TextEditingController resultText,
    BuildContext context,
    WidgetRef ref,
  ) async {
    String? error;
    if (selectedIndex == 0) {
      error = 'Please select something to summarize';
    } else if (selectedIndex == 1 && text.text.isEmpty) {
      error = 'Please type in the text/url you want to summarize';
    } else if (selectedIndex == 2 && document == null) {
      error = 'Please upload a valid file to summarize';
    }

    if (error == null) {
      ref.read(_isLoading.notifier).state = true;
      FocusScope.of(context).unfocus();

      final repo = ref.read(summaryRepository);
      final result = selectedIndex == 1
          ? await repo.summarize(text.text, lines)
          : await repo.summarizeFile(document!, lines);

      ref.read(_isLoading.notifier).state = false;
      if (result.isSuccess) {
        resultText.text = result.data ?? '';
      } else {
        context.showSnackMessage(result.message ?? '');
      }
    } else {
      context.showSnackMessage(error);
    }
  }

  Future<String?> _getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err) {
      debugPrint("Cannot get download folder path");
    }
    return directory?.path;
  }

  Future<File> get _localFile async {
    final path = await _getDownloadPath();
    final date = (formatDate(
        DateTime.now(), [yyyy, '', mm, '', dd, '_', HH, '-', nn, '-', ss]));
    String downloadName = "${date}_SumryMan.pdf";
    return File('$path/$downloadName');
  }

  Future<File?> _writeDownload(String result) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      if (!status.isGranted) return null;
    }
    final file = await _localFile;
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Padding(
              padding: const pw.EdgeInsets.all(10),
              child: pw.Text(result),
            );
          }),
    );

    return file.writeAsBytes(await pdf.save());
  }

  handleDownload(
    TextEditingController controller,
    BuildContext context,
  ) async {
    if (controller.text.isEmpty) {
      context.showSnackMessage('Nothing to download');
    } else {
      _writeDownload(controller.text).then(
        (file) {
          if (file != null) {
            context.showSnackMessage('File downloaded to ${file.path}');
          } else {
            context.showSnackMessage('Failed to save file');
          }
        },
      );
    }
  }
}
