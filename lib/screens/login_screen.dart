import 'package:flutter/material.dart';

import '../components/buttons.dart';
import '../components/spacers.dart';
import '../utils/designs/assets.dart';
import '../utils/designs/colors.dart';
import '../utils/designs/routes.dart';
import '../utils/designs/styles.dart';
import '../utils/res/res_profile.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final double space = 18;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 45),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  ResLogInScreen.welcome,
                  style: sSignUpTextStyle,
                ),
              ),
              // vSpace(space -2),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  ResLogInScreen.loginToAccount,
                  style: sSignUpTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: kTextColor,
                  ),
                ),
              ),
              vSpace(space * 3),
              TextFormField(
                controller: emailController,
                cursorColor: Colors.black,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: ResSignUpScreen.email,
                  hintStyle: sHintTextStyle,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                    borderSide: BorderSide(color: kPrimaryColor, width: 1.4),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                    borderSide: BorderSide(color: kPrimaryColor, width: 1.4),
                  ),
                ),
              ),
              vSpace(space * 1.5),
              TextFormField(
                controller: passwordController,
                cursorColor: Colors.black,
                obscureText: isPasswordVisible,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    color: kPrimaryColor,
                    icon: isPasswordVisible
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    onPressed: () => setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    }),
                  ),
                  hintText: ResSignUpScreen.password,
                  hintStyle: sHintTextStyle,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                    borderSide: BorderSide(color: kPrimaryColor, width: 1.4),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                    borderSide: BorderSide(color: kPrimaryColor, width: 1.4),
                  ),
                ),
              ),
              vSpace(space * 3.0),
              AppButton(
                onPressed: () {},
                text: ResLogInScreen.login,
              ),
              vSpace(space / 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ResLogInScreen.dontHaveAnAccount,
                    style: sSignUpTextStyle.copyWith(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  hSpace(space / 3),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.signup);
                    },
                    child: Text(
                      ResLogInScreen.signUp,
                      style: sSignUpTextStyle.copyWith(
                        color: kSocialButtonColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
              vSpace(space),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      thickness: 2.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      ResSignUpScreen.oR,
                      style: sButtonTextStyle.copyWith(
                        color: Colors.black,
                        fontSize: 9.9,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      thickness: 2.0,
                    ),
                  ),
                ],
              ),
              vSpace(space * 1.5),
              socialButton(
                onClick: () {},
                text: ResSocialLogIn.continueWithGoogle,
                image: Assets.googleLogo,
                fillColor: kPrimaryColor,
                textColor: Colors.white,
              ),
              vSpace(space),
              socialButton(
                onClick: () {},
                text: ResSocialLogIn.continueWithFacebook,
                image: Assets.facebookLogo,
                fillColor: Colors.white,
                textColor: kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
