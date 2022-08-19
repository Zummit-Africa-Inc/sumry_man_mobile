import 'package:flutter/material.dart';
import 'package:sumry_app/utils/designs/colors.dart';

import '../utils/designs/styles.dart';

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

socialButton({
  required GestureTapCallback? onClick,
  required String text,
  required String image,
  required Color fillColor,
  required Color textColor,
  double leftPadding = 0,
  double rightPadding = 0,
  double topPadding = 10,
  double bottomPadding = 10,
  double borderRadius = 8,
  MainAxisAlignment viewAlignment = MainAxisAlignment.center,
  TextStyle? textStyle,
  FontWeight fontWeight = FontWeight.w600,
}) =>
    InkWell(
      onTap: onClick,
      child: Container(
        // width: 220
        height: 45.0,
        padding: EdgeInsets.only(
            left: leftPadding,
            right: rightPadding,
            top: topPadding,
            bottom: bottomPadding),
        decoration: BoxDecoration(
          color: fillColor,
          border: Border.all(color: kPrimaryColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: viewAlignment,
          children: [
            Image(
              image: AssetImage(image),
              width: 30.0,
              height: 30.0,
            ),
            Text(text,
                style: sSignUpTextStyle.copyWith(
                  color: textColor,
                  fontWeight: fontWeight,
                  fontSize: 12,
                ))
          ],
        ),
      ),
    );
