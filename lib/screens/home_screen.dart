import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:date_format/date_format.dart';
import 'package:path_provider/path_provider.dart';

import '../components/app_bar.dart';
import '../components/buttons.dart';
import '../components/drawer.dart';
import '../components/input_field.dart';
import '../components/spacers.dart';
import '../services/summary_api.dart';
import '../utils/designs/dimens.dart';
import '../utils/designs/routes.dart';
import '../utils/res/res_profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  var filePath = "";
  var fileName = "";
  var isLoading = false;
  FilePickerResult? Result;
  var selectedIndex = 0;
  final summaryApi = SummaryApi();
  final textController = TextEditingController();
  final resultController = TextEditingController();

  Future<void> _copyToClipboard() async {
    Clipboard.setData(ClipboardData(text: resultController.text)).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: Theme.of(context).colorScheme.primary,
          content: resultController.text.isEmpty
              ? const Text('Nothing to copy')
              : const Text('Copied to clipboard'),
        ),
      );
    });
  }

  Future<String?> getDownloadPath() async {
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
    final path = await getDownloadPath();
    final date = (formatDate(
        DateTime.now(), [yyyy, '', mm, '', dd, '_', HH, '-', nn, '-', ss]));
    String downloadName = "${date}_SumryMan.txt";
    return File('$path/$downloadName');
  }

  Future<File> writeDownload(String result) async {
    final file = await _localFile;
    return file.writeAsString(result, mode: FileMode.append);
  }

  _handleDownload() async {
    if (resultController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: const Text("Nothing to download"),
      ));
      return;
    } else {
      final file = await writeDownload(resultController.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 4),
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Text("file downloaded to ${file.path}"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: const DefaultAppBar(
        trailing: LoginRegisterButton(),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: sPadding),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: 0.6,
                child: Text(
                  ResHomeScreen.header,
                  style: theme.textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
            vSpace(sSecondaryPadding),
            Text(
              ResHomeScreen.subHeader,
              style: theme.textTheme.overline?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: sSecondaryPadding),
              child: InputField(
                state: InputFieldState(
                  onClick: () {
                    selectedIndex = 0;
                  },
                  controller: textController,
                  textAlign: TextAlign.center,
                  label: ResHomeScreen.enterText,
                ),
              ),
            ),
            InputField(
              state: InputFieldState(
                textAlign: TextAlign.center,
                onClick: () async {
                  selectedIndex = 1;
                  final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['txt', 'docx']);
                  Result = result;
                  setState(() {});
                  if (result != null) {
                    selectedIndex = 1;
                    PlatformFile file = result.files.first;

                    filePath = file.path!;
                    fileName = file.name;
                  } else {
                    // User canceled the picker
                  }
                },
                label: Result == null ? ResHomeScreen.uploadText : fileName,
                //maxLines: ,
                icon: const Icon(
                  Icons.upload,
                ),
                readOnly: true,
              ),
            ),
            vSpace(sPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  text: ResHomeScreen.clear,
                  backgroundColor: theme.colorScheme.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  onPressed: () {
                    setState(() {
                      textController.clear();
                      Result = null;
                    });
                  },
                ),
                AppButton(
                  text: ResHomeScreen.summarize,
                  backgroundColor: theme.colorScheme.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    FocusScope.of(context).unfocus();
                    debugPrint("Selected is $selectedIndex");
                    final Map<String, dynamic> result = selectedIndex == 0
                        ? await summaryApi.summarize(text: textController.text)
                        : await summaryApi.sendRequest(filePath, fileName);

                    if (result["status"] == "success") {
                      setState(() {
                        isLoading = false;
                        resultController.text = result["message"];
                        Result = null;
                        selectedIndex = 0;
                        textController.text = "";
                      });
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("An error has occurred"),
                          content: Text(result["message"].toString()),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                color: Colors.black,
                                padding: const EdgeInsets.all(10),
                                child: const Text(
                                  "okay",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            vSpace(sPadding),
            InputField(
              state: InputFieldState(
                icon: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : null,
                label: ResHomeScreen.result,
                controller: resultController,
                maxLines: 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: sSecondaryPadding),
              child: Align(
                alignment: Alignment.centerRight,
                child: AppButton(
                  onPressed: _copyToClipboard,
                  text: ResHomeScreen.copy,
                  icon: const Icon(
                    Icons.copy,
                    color: Colors.white,
                  ),
                  backgroundColor: theme.colorScheme.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    text: ResCommentScreen.leaveUsAComment,
                    onPressed: () =>
                        Navigator.pushNamed(context, Routes.comment),
                    backgroundColor: Colors.transparent,
                    border: theme.colorScheme.primary,
                    textColor: theme.colorScheme.primary,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  hSpace(sSecondaryPadding),
                  AppButton(
                    onPressed: _handleDownload,
                    text: ResHomeScreen.download,
                    backgroundColor: theme.colorScheme.primary,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ],
              ),
            ),
            vSpace(sPadding),
          ],
        ),
      ),
    );
  }
}
