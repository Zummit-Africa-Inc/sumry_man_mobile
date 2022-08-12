import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final String text;

  const AppButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor ?? theme.colorScheme.primary,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
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
