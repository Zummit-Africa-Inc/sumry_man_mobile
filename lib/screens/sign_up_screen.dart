import 'package:flutter/material.dart';
import 'package:sumry_app/utilis/designs/colors.dart';
import 'package:sumry_app/utilis/designs/styles.dart';
import 'package:sumry_app/components/spacers.dart';
import 'package:sumry_app/utilis/res/res_profile.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final double space = 18;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Material(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  ResSignUpScreen.welcome,
                  style: sSignUpTextStyle,
                ),
                // vSpace(space),
                Text(
                  ResSignUpScreen.register,
                  style: sSignUpTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: kTextColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
