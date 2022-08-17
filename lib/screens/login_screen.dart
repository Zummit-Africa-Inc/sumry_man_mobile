import 'package:flutter/material.dart';
import 'package:sumry_app/components/spacers.dart';
import 'package:sumry_app/screens/sign_up_screen.dart';
import 'package:sumry_app/utilis/designs/assets.dart';
import 'package:sumry_app/utilis/designs/colors.dart';
import 'package:sumry_app/utilis/designs/styles.dart';
import 'package:sumry_app/utilis/res/res_profile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  ResLogInScreen.welcome,
                  style: sHeadingTextStyle,
                ),
              ),
              vSpace(8),
              Center(
                child: Text(
                  ResLogInScreen.loginToAccount,
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
                      ResLogInScreen.login,
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
                    Text(ResLogInScreen.dontHaveAnAccount,
                        style: sTextTextStyle),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        ResLogInScreen.signUp,
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
                        style: const TextStyle(color: kTextColor),
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
                        Text(ResSocial.continueWithGoogle,
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
                          ResSocial.continueWithFacebook,
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
