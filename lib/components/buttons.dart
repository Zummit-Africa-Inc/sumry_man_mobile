import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumry_app/components/spacers.dart';
import 'package:sumry_app/utilis/designs/colors.dart';
import 'package:sumry_app/utilis/designs/styles.dart';

primaaryMediumButton(
        {GestureTapCallback? onPressed,
        double leftPadding = 0,
        double rightPadding = 0,
        double bottomPadding = 10,
        double topPadding = 10,
        double borderRadius = 8,
        required String text}) =>
    InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(
          left: leftPadding,
          right: rightPadding,
          top: topPadding,
          bottom: bottomPadding,
        ),
        // width: 280,
        height: 45.0,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: sSignUpTextStyle.copyWith(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );

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
