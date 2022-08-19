import 'package:flutter/material.dart';
import 'package:sumry_app/utils/designs/colors.dart';

import '../components/app_bar.dart';
import '../components/buttons.dart';
import '../components/drawer.dart';
import '../components/input_field.dart';
import '../components/spacers.dart';
import '../utils/designs/dimens.dart';
import '../utils/designs/routes.dart';
import '../utils/res/res_profile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
            const _UploadOrInput(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: sSecondaryPadding),
                  child: InputField(
                    state: InputFieldState(
                      textAlign: TextAlign.center,
                      label: ResHomeScreen.enterText,
                    ),
                  ),
                ),
                InputField(
                  state: InputFieldState(
                    textAlign: TextAlign.center,
                    label: ResHomeScreen.uploadText,
                    maxLines: 2,
                    icon: Icon(
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
              ),
            ),
            vSpace(sPadding),
            const InputField(
              state: InputFieldState(
                label: ResHomeScreen.result,
                maxLines: 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: sSecondaryPadding),
              child: Align(
                alignment: Alignment.centerRight,
                child: AppButton(
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
  final ValueChanged<int>? onChanged;

  const _UploadOrInput({Key? key, required this.children, this.onChanged})
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
          onChanged: (_) => setState(
            () {
              _selected = index;
              widget.onChanged?.call(_selected);
            },
          ),
        ),
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
