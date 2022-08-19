import 'package:flutter/material.dart';

import '../components/buttons.dart';
import '../components/spacers.dart';
import '../utils/designs/assets.dart';
import '../utils/designs/colors.dart';
import '../utils/designs/routes.dart';
import '../utils/designs/styles.dart';
import '../utils/res/res_profile.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final double space = 18;

  bool isPasswordVisible = true;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
                  ResSignUpScreen.welcome,
                  style: sSignUpTextStyle,
                ),
              ),
              // vSpace(space -2),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  ResSignUpScreen.register,
                  style: sSignUpTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: kTextColor,
                  ),
                ),
              ),
              vSpace(space * 2),
              TextFormField(
                controller: fullNameController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: ResSignUpScreen.fullName,
                  hintStyle: sHintTextStyle,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor, width: 1.4),
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor, width: 1.4),
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  ),
                ),
              ),
              vSpace(space * 1.2),
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
              vSpace(space * 1.2),
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
              vSpace(space * 1.2),
              TextFormField(
                controller: confirmPasswordController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: ResSignUpScreen.confirmPassword,
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
                text: ResSignUpScreen.signUp,
              ),
              vSpace(space / 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ResSignUpScreen.alreadyHaveAnAccount,
                    style: sSignUpTextStyle.copyWith(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  hSpace(space / 3),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.login);
                    },
                    child: Text(ResSignUpScreen.login,
                        style: sSignUpTextStyle.copyWith(
                          color: kSocialButtonColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )),
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
              vSpace(space),
              socialButton(
                onClick: () {},
                text: ResSocialSignUp.signUpWithGoogle,
                image: Assets.googleLogo,
                fillColor: kPrimaryColor,
                textColor: Colors.white,
              ),
              vSpace(space),
              socialButton(
                onClick: () {},
                text: ResSocialSignUp.signUpWithFaceBook,
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
