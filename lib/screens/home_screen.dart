import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sumry_app/services/summary_api.dart';
import 'package:sumry_app/utils/designs/colors.dart';

import '../components/app_bar.dart';
import '../components/buttons.dart';
import '../components/drawer.dart';
import '../components/input_field.dart';
import '../components/spacers.dart';
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
  String filePath = "";
  String fileName = "";
  FilePickerResult? Result;
  int selectedIndex = 0;
  final summaryApi = SummaryApi();
  TextEditingController textController = TextEditingController();
  TextEditingController resultController = TextEditingController();

  Future<void> _copyToClipboard() async {
    Clipboard.setData(ClipboardData(text: resultController.text)).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: Theme.of(context).colorScheme.primary,
          content: const Text('Copied to clipboard'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: DefaultAppBar(
        trailing: AppButton(
          text: ResHomeScreen.loginRegister,
          onPressed: () {},
          textColor: theme.colorScheme.primary,
        ),
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
            _UploadOrInput(
              onChanged: (value) {
                selectedIndex = value;
              },
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: sSecondaryPadding),
                  child: InputField(
                    state: InputFieldState(
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

                        print(file.name);
                        print(file.bytes);
                        print(file.size);
                        print(file.extension);
                        print(file.path);
                        print(filePath);
                      } else {
                        // User canceled the picker
                      }
                    },
                    label: Result == null ? ResHomeScreen.uploadText : fileName,
                    maxLines: 2,
                    icon: const Icon(
                      Icons.upload,
                    ),
                    readOnly: true,
                  ),
                ),
              ],
            ),
            vSpace(sSecondaryPadding / 2),
            Align(
              alignment: Alignment.centerRight,
              child: AppButton(
                text: ResHomeScreen.summarize,
                backgroundColor: theme.colorScheme.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                onPressed: () async {
                  setState(() {
                    resultController.text = "";
                  });
                  FocusScope.of(context).unfocus();
                  debugPrint("Selected is $selectedIndex");
                  final Map<String, dynamic> result = selectedIndex == 0
                      ? await summaryApi.summarize(text: textController.text)
                      : await summaryApi.sendRequest(filePath, fileName);

                  if (result["status"] == "success") {
                    setState(() {
                      resultController.text = result["message"];
                      Result = null;
                      selectedIndex = 0;
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("An error has occured"),
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
            ),
            vSpace(sPadding),
            InputField(
              state: InputFieldState(
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

class _UploadOrInput extends StatefulWidget {
  final List<Widget> children;
  final ValueChanged<int> onChanged;

  const _UploadOrInput(
      {Key? key, required this.children, required this.onChanged})
      : super(key: key);

  @override
  State<_UploadOrInput> createState() => __UploadOrInputState();
}

class __UploadOrInputState extends State<_UploadOrInput> {
  int _selected = 0;

  Widget _buildItem(Widget item, int index) {
    return Row(
      children: [
        Radio(
            activeColor: kButtonColor,
            value: index,
            groupValue: _selected,
            onChanged: (_) {
              setState(() {
                _selected = index;
                widget.onChanged.call(_selected);
              });
            }),
        hSpace(sSecondaryPadding),
        Expanded(child: item),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];
    for (int i = 0; i < widget.children.length; ++i) {
      children.add(_buildItem(widget.children[i], i));
    }

    return Column(
      children: children,
    );
  }
}
