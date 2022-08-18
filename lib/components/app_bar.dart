import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/designs/dimens.dart';
import 'spacers.dart';

class DefaultAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final Widget? trailing;

  const DefaultAppBar({
    Key? key,
    this.title,
    this.leading,
    this.trailing,
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
      leading: leading,
      centerTitle: true,
      title: title != null
          ? Text(
              title!,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
            )
          : null,
      actions: trailing != null
          ? [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  trailing!,
                  hSpace(sPadding),
                ],
              )
            ]
          : null,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
