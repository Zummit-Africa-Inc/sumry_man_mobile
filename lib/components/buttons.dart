import 'package:flutter/material.dart';

import '../utils/designs/dimens.dart';
import 'spacers.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final String text;
  final EdgeInsets? padding;
  final Widget? icon;
  final Color? border;

  const AppButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.icon,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: padding ?? const EdgeInsets.all(8),
        backgroundColor: backgroundColor ?? theme.colorScheme.secondary,
        side: BorderSide(color: border != null ? border! : Colors.transparent),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sSecondaryPadding / 2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...{
            icon!,
            hSpace(sSecondaryPadding / 2),
          },
          Text(
            text,
            style: theme.textTheme.button?.copyWith(
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
