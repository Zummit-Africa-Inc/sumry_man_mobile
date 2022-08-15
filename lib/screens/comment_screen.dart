import 'package:flutter/material.dart';

import '../components/app_bar.dart';
import '../components/buttons.dart';
import '../components/copyright.dart';
import '../components/drawer.dart';
import '../components/images.dart';
import '../components/input_field.dart';
import '../components/spacers.dart';
import '../utils/designs/dimens.dart';
import '../utils/res/res_profile.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: const DefaultAppBar(
        trailing: UserImage(null),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(sPadding, sPadding, sPadding, 0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Text(
                  ResCommentScreen.leaveUsAComment,
                  style: theme.textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
            vSpace(sPadding + sPadding / 2),
            InputField(
              label: ResCommentScreen.fullName,
            ),
            vSpace(sPadding),
            InputField(
              label: ResCommentScreen.emailAddress,
            ),
            vSpace(sPadding),
            Expanded(
              flex: 2,
              child: InputField(
                label: ResCommentScreen.commentHere,
                expands: true,
              ),
            ),
            vSpace(sPadding),
            Align(
              alignment: Alignment.centerRight,
              child: AppButton(
                text: ResCommentScreen.leaveComment,
              ),
            ),
            const Spacer(),
            const Copyright(),
          ],
        ),
      ),
    );
  }
}
