import 'package:flutter/material.dart';
import 'package:sumry_app/utils/designs/colors.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final String text;
  final EdgeInsets? padding;

  const AppButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: padding ?? const EdgeInsets.all(8),
      color: backgroundColor ?? kButtonColor,
      child: InkWell(
        onTap: onPressed,
        child: Text(
          text,
          style: theme.textTheme.button?.copyWith(
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
