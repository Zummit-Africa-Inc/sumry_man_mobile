import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sumry_man/components/copyright.dart';
import 'package:sumry_man/utils/designs/colors.dart';
import 'package:sumry_man/utils/designs/styles.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../components/app_bar.dart';
import '../../components/buttons.dart';
import '../../components/drawer.dart';
import '../../components/input_field.dart';
import '../../components/spacers.dart';
import '../../data/repository/summary_repository.dart';
import '../../utils/designs/dimens.dart';
import '../../utils/designs/routes.dart';
import '../../utils/res/res_profile.dart';
import '../../utils/extensions.dart';
import 'home_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  var isLoading = false;
  var fileName = '';
  File? document;
  var selectedIndex = 0;
  var lines = 1;

  final textController = TextEditingController();
  final resultController = TextEditingController();

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
    String downloadName = "${date}_SumryMan.pdf";
    return File('$path/$downloadName');
  }

  Future<File?> writeDownload(String result) async {
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

  _handleDownload() async {
    if (resultController.text.isEmpty) {
      context.showSnackMessage('Nothing to download');
    } else {
      writeDownload(resultController.text).then(
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viewModel = ref.read(homeViewModel);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 900) {
        return webLayout(theme, viewModel, context);
      } else {
        return mobileLayout(theme, viewModel, context);
      }
    });
  }

  Scaffold mobileLayout(
      ThemeData theme, HomeViewModel viewModel, BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: const DefaultAppBar(
        trailing: LoginRegisterButton(),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
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
                  onClick: () => setState(() => selectedIndex = 1),
                  controller: textController,
                  textAlign: TextAlign.center,
                  label: ResHomeScreen.enterText,
                ),
              ),
            ),
            InputField(
              state: InputFieldState(
                textAlign: TextAlign.center,
                onClick: _selectFile,
                label: document == null ? ResHomeScreen.uploadText : fileName,
                icon: const Icon(
                  Icons.upload,
                ),
                readOnly: true,
              ),
            ),
            vSpace(sSecondaryPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppButton(
                  text: ResHomeScreen.clear,
                  backgroundColor: theme.colorScheme.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  onPressed: _clearInput,
                ),
                const Spacer(),
                if (selectedIndex != 2) ...{
                  SizedBox(
                    width: 80,
                    child: DropdownTextField<int>(
                      value: lines,
                      items: List.generate(10, (index) => index + 1),
                      label: ResHomeScreen.lineCount,
                      onItemChanged: (value) {
                        lines = value ?? lines;
                      },
                    ),
                  )
                },
                hSpace(sSecondaryPadding / 2),
                AppButton(
                  isLoading: isLoading,
                  text: ResHomeScreen.summarize,
                  backgroundColor: theme.colorScheme.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  onPressed: _summarize,
                ),
              ],
            ),
            vSpace(sSecondaryPadding),
            InputField(
              state: InputFieldState(
                label: ResHomeScreen.result,
                controller: resultController,
                readOnly: true,
                maxLines: 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: sSecondaryPadding),
              child: Align(
                alignment: Alignment.centerRight,
                child: AppButton(
                  onPressed: () {
                    viewModel.copyToClipboard(resultController.text, context);
                  },
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
                    onPressed: () => Navigator.pushNamed(
                      context,
                      Routes.comment,
                    ),
                    backgroundColor: Colors.transparent,
                    border: theme.colorScheme.primary,
                    textColor: theme.colorScheme.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  hSpace(sSecondaryPadding),
                  AppButton(
                    onPressed: _handleDownload,
                    text: ResHomeScreen.download,
                    backgroundColor: theme.colorScheme.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
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

  Scaffold webLayout(
      ThemeData theme, HomeViewModel viewModel, BuildContext context) {
    return Scaffold(
      appBar: const WebAppBar(),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: sPadding * 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: sPadding * 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: sPadding * 16,
                            child: Text(
                              ResHomeScreen.header,
                              style: theme.textTheme.headline5?.copyWith(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        vSpace(sSecondaryPadding),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            ResHomeScreen.fastFree,
                            style: theme.textTheme.overline?.copyWith(
                              fontSize: 15,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                        Image.asset(
                          "assets/images/welcome_2.png",
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: sSecondaryPadding),
                          child: InputField(
                            state: InputFieldState(
                              onClick: () => setState(() => selectedIndex = 1),
                              controller: textController,
                              textAlign: TextAlign.center,
                              label: ResHomeScreen.enterText,
                            ),
                          ),
                        ),
                        InputField(
                          state: InputFieldState(
                            textAlign: TextAlign.center,
                            onClick: _selectFile,
                            label: document == null
                                ? ResHomeScreen.uploadText
                                : fileName,
                            icon: const Icon(
                              Icons.upload,
                            ),
                            readOnly: true,
                          ),
                        ),
                        vSpace(sSecondaryPadding),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (selectedIndex != 2) ...{
                              SizedBox(
                                width: 80,
                                child: DropdownTextField<int>(
                                  value: lines,
                                  items:
                                      List.generate(10, (index) => index + 1),
                                  label: ResHomeScreen.lineCount,
                                  onItemChanged: (value) {
                                    lines = value ?? lines;
                                  },
                                ),
                              )
                            },
                            AppButton(
                              isLoading: isLoading,
                              text: ResHomeScreen.summarize,
                              backgroundColor: theme.colorScheme.primary,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              onPressed: _summarize,
                            ),
                          ],
                        ),
                        vSpace(sSecondaryPadding),
                        InputField(
                          state: InputFieldState(
                            label: ResHomeScreen.result,
                            controller: resultController,
                            readOnly: true,
                            maxLines: 5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: sSecondaryPadding),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: AppButton(
                              onPressed: () {
                                viewModel.copyToClipboard(
                                    resultController.text, context);
                              },
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
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  Routes.comment,
                                ),
                                backgroundColor: Colors.transparent,
                                border: theme.colorScheme.primary,
                                textColor: theme.colorScheme.primary,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              hSpace(sSecondaryPadding),
                              AppButton(
                                onPressed: _handleDownload,
                                text: ResHomeScreen.download,
                                backgroundColor: theme.colorScheme.primary,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                        vSpace(sPadding),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: sPadding * 2,
            ),
            Container(
              color: kHomeBGColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: sPadding * 2, vertical: sPadding * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/home_img.png",
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ResHomeScreen.getSummary,
                          style: theme.textTheme.headline5?.copyWith(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        vSpace(sSecondaryPadding),
                        SizedBox(
                          width: 350,
                          child: Text(
                            ResHomeScreen.subHeader,
                            style: theme.textTheme.overline?.copyWith(
                              fontSize: 15,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: kPrimaryColor,
              height: sPadding * 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            ResHomeScreen.sumry,
                            style: sText3TextStyle,
                          ),
                          Text(
                            ResHomeScreen.man,
                            style: sText5TextStyle,
                          )
                        ],
                      ),
                      const SizedBox(
                        width: sPadding / 2,
                      ),
                      Text(
                        ResHomeScreen.withLove,
                        style: sText4TextStyle,
                      ),
                      const SizedBox(
                        width: sPadding / 2,
                      ),
                      Image.asset(
                        "assets/images/logomark_white.png",
                      ),
                      const SizedBox(
                        width: sPadding / 2,
                      ),
                      Image.asset(
                        "assets/images/zummit_africa.png",
                      ),
                    ],
                  ),
                  const WebCopyright()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
    resultController.dispose();
  }

  _selectFile() async {
    selectedIndex = 2;
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt', 'docx'],
    );

    if (result != null) {
      final file = result.files.first;

      setState(() {
        if (kIsWeb) {
          document = File.fromRawPath(file.bytes!);
        } else {
          document = File(file.path!);
        }
        fileName = file.name;
      });
    }
  }

  _clearInput() {
    setState(() {
      textController.clear();
      document = null;
      selectedIndex = 0;
      FocusScope.of(context).unfocus();
    });
  }

  _summarize() async {
    String? error;
    if (selectedIndex == 0) {
      error = 'Please select something to summarize';
    } else if (selectedIndex == 1 && textController.text.isEmpty) {
      error = 'Please type in the text/url you want to summarize';
    } else if (selectedIndex == 2 && document == null) {
      error = 'Please upload a valid file to summarize';
    }

    if (error == null) {
      setState(() => isLoading = true);
      FocusScope.of(context).unfocus();

      final repo = ref.read(summaryRepository);
      final result = selectedIndex == 1
          ? await repo.summarize(textController.text, lines)
          : await repo.summarizeFile(document!, lines);

      setState(() {
        isLoading = false;
        if (result.isSuccess) {
          resultController.text = result.data ?? '';
        } else {
          context.showSnackMessage(result.message ?? '');
        }
      });
    } else {
      context.showSnackMessage(error);
    }
  }
}
