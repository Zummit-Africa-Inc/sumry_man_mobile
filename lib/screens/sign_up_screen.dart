import 'package:flutter/material.dart';
import 'package:sumry_app/components/spacers.dart';
import 'package:sumry_app/screens/login_screen.dart';
import 'package:sumry_app/utilis/designs/assets.dart';
import 'package:sumry_app/utilis/designs/colors.dart';
import 'package:sumry_app/utilis/designs/styles.dart';
import 'package:sumry_app/utilis/res/res_profile.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Text(
                  ResSignUpScreen.signUp,
                  style: sHeadingTextStyle,
                ),
              ),
              vSpace(8),
              Center(
                child: Text(
                  ResSignUpScreen.register,
                  style: sHeading2TextStyle,
                ),
              ),
              vSpace(22),
              Center(
                child: SizedBox(
                  height: 47,
                  width: 324,
                  child: TextField(
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: ResSignUpScreen.fullName,
                      hintStyle: sHintTextStyle,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
              vSpace(24),
              Center(
                child: SizedBox(
                  height: 47,
                  width: 324,
                  child: TextField(
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: ResSignUpScreen.email,
                      hintStyle: sHintTextStyle,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
              vSpace(24),
              Center(
                child: SizedBox(
                  height: 47,
                  width: 324,
                  child: TextField(
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      suffix: Image.asset(
                        Assets.eyeLogo,
                      ),
                      hintText: ResSignUpScreen.password,
                      hintStyle: sHintTextStyle,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
              vSpace(48),
              Center(
                child: SizedBox(
                  height: 47,
                  width: 324,
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        kPrimaryColor,
                      ),
                    ),
                    child: Text(
                      ResSignUpScreen.welcome,
                      style: sSignUpButtonTextStyle,
                    ),
                  ),
                ),
              ),
              vSpace(9),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ResSignUpScreen.alreadyHaveAnAccount,
                      style: sTextTextStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        ResSignUpScreen.login,
                        style: sText2TextStyle,
                      ),
                    ),
                  ],
                ),
              ),
              vSpace(14),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                        width: 145,
                        child: Divider(
                          color: kDividerColor,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        ResSignUpScreen.oR,
                        style: sOrTextStyle,
                      ),
                    ),
                    const SizedBox(
                        width: 145,
                        child: Divider(
                          color: kDividerColor,
                        ))
                  ],
                ),
              ),
              vSpace(14),
              Center(
                child: SizedBox(
                  height: 54,
                  width: 327,
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        kPrimaryColor,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.googleLogo,
                        ),
                        hSpace(8),
                        Text(ResSignUpScreen.signUpWithGoogle,
                            style: sSignUpButtonTextStyle),
                      ],
                    ),
                  ),
                ),
              ),
              vSpace(16),
              Center(
                child: SizedBox(
                  height: 47,
                  width: 324,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.facebookLogo,
                        ),
                        hSpace(8),
                        Text(
                          ResSignUpScreen.signUpWithGoogle,
                          style: sFacebookButtonTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
