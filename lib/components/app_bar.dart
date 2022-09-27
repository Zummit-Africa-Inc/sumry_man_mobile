import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sumry_man/components/buttons.dart';

import '../utils/designs/dimens.dart';
import '../utils/designs/styles.dart';
import '../utils/res/res_profile.dart';
import 'spacers.dart';

class DefaultAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget? title;
  final Widget? trailing;
  final double padding;
  final Color? color;

  const DefaultAppBar({
    Key? key,
    this.title,
    this.trailing,
    this.padding = sPadding,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      foregroundColor: Colors.black,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: theme.colorScheme.primary,
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      automaticallyImplyLeading: title == null,
      titleSpacing: 0,
      title: title,
      actions: trailing != null
          ? [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  trailing!,
                  hSpace(padding),
                ],
              )
            ]
          : null,
      backgroundColor: color ?? Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class WebAppBar extends StatelessWidget with PreferredSizeWidget {
  const WebAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: sPadding),
        child: Row(
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
      ),
      leadingWidth: sPadding * 7,
      actions: const [
        Padding(
          padding: EdgeInsets.fromLTRB(0, sPadding / 2, sPadding, sPadding / 2),
          child: LoginRegisterButton(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
