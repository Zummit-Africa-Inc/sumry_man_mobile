import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/buttons.dart';
import '../../components/input_field.dart';
import '../../components/spacers.dart';
import '../../utils/designs/dimens.dart';
import '../../utils/designs/routes.dart';
import '../../utils/res/res_profile.dart';
import 'state.dart';

class HomeForm extends ConsumerStatefulWidget {
  const HomeForm({super.key});

  @override
  ConsumerState<HomeForm> createState() => _HomeFieldsState();
}

class _HomeFieldsState extends ConsumerState<HomeForm> {
  final textController = TextEditingController();
  final resultController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(homeState);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: sSecondaryPadding),
          child: InputField(
            state: InputFieldState(
              onClick: () => state.selectText(ref),
              controller: textController,
              textAlign: TextAlign.center,
              label: ResHomeScreen.enterText,
            ),
          ),
        ),
        InputField(
          state: InputFieldState(
            textAlign: TextAlign.center,
            onClick: () => state.selectFile(ref),
            label: state.document?.name ?? ResHomeScreen.uploadText,
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
              onPressed: () => state.clearInput(textController, context, ref),
            ),
            const Spacer(),
            if (state.selectedIndex != 2) ...{
              SizedBox(
                width: 80,
                child: DropdownTextField<int>(
                  value: state.lines,
                  items: List.generate(10, (index) => index + 1),
                  label: ResHomeScreen.lineCount,
                  onItemChanged: (value) {
                    if (value != null && value != state.lines) {
                      state.updateLines(ref, value);
                    }
                  },
                ),
              )
            },
            hSpace(sSecondaryPadding / 2),
            AppButton(
              isLoading: state.isLoading,
              text: ResHomeScreen.summarize,
              backgroundColor: theme.colorScheme.primary,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              onPressed: () => state.summarize(
                textController,
                resultController,
                context,
                ref,
              ),
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
          child: AppButton(
            onPressed: () =>
                state.copyToClipboard(resultController.text, context),
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
        Row(
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
            if (!kIsWeb) ...{
              hSpace(sSecondaryPadding),
              AppButton(
                onPressed: () => state.handleDownload(textController, context),
                text: ResHomeScreen.download,
                backgroundColor: theme.colorScheme.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            }
          ],
        ),
        vSpace(sPadding),
      ],
    );
  }

  @override
  void dispose() {
    textController.dispose();
    resultController.dispose();
    super.dispose();
  }
}
