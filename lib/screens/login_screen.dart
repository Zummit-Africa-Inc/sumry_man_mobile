import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/app_bar.dart';
import '../components/buttons.dart';
import '../components/drawer.dart';
import '../components/input_field.dart';
import '../components/or.dart';
import '../components/spacers.dart';
import '../utils/designs/assets.dart';
import '../utils/designs/colors.dart';
import '../utils/designs/dimens.dart';
import '../utils/designs/routes.dart';
import '../utils/res/res_profile.dart';

enum LoginScreenState { login, signup }

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var state = LoginScreenState.login;
  final form = GlobalKey<FormState>();

  void _switch() {
    setState(() {
      if (state == LoginScreenState.login) {
        state = LoginScreenState.signup;
      } else {
        state = LoginScreenState.login;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLogin = state == LoginScreenState.login;

    return Scaffold(
      appBar: DefaultAppBar(
        trailing: GestureDetector(
          onTap: () => Navigator.pushNamed(context, Routes.home),
          child: Text(
            'Skip',
            style: theme.textTheme.caption?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Form(
          key: form,
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: sPadding,
              vertical: sPadding * 2,
            ),
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  isLogin ? ResLoginScreen.header1 : ResLoginScreen.header2,
                  style: theme.textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              vSpace(sSecondaryPadding / 2),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  isLogin
                      ? ResLoginScreen.subHeader1
                      : ResLoginScreen.subHeader2,
                  style: theme.textTheme.bodyText1,
                ),
              ),
              vSpace(sPadding * 2),
              if (!isLogin) ...{
                InputField(
                  state: InputFieldState(
                    label: ResLoginScreen.fullName,
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                vSpace(sPadding),
              },
              InputField(
                state: InputFieldState(
                  label: ResLoginScreen.email,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
              ),
              vSpace(sPadding),
              PasswordField(
                state: InputFieldState(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              if (!isLogin) ...{
                vSpace(sPadding),
                const PasswordField(
                  state: InputFieldState(
                    label: ResLoginScreen.confirmPassword,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
              },
              vSpace(sPadding * 2),
              AppButton(
                onPressed: () {},
                backgroundColor: theme.colorScheme.primary,
                text: isLogin ? ResLoginScreen.login : ResLoginScreen.signUp,
              ),
              vSpace(sSecondaryPadding / 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLogin
                        ? ResLoginScreen.dontHaveAnAccount
                        : ResLoginScreen.alreadyHaveAnAccount,
                    style: theme.textTheme.caption?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  hSpace(sSecondaryPadding / 4),
                  InkWell(
                    onTap: _switch,
                    child: Text(
                      isLogin ? ResLoginScreen.signUp : ResLoginScreen.login,
                      style: theme.textTheme.caption?.copyWith(
                        color: kSocialButtonColor,
                      ),
                    ),
                  )
                ],
              ),
              vSpace(sPadding),
              const Or(),
              vSpace(sPadding),
              AppButton(
                onPressed: () {},
                text: isLogin
                    ? ResLoginScreen.continueWithGoogle
                    : ResLoginScreen.signupWithGoogle,
                backgroundColor: theme.colorScheme.primary,
                icon: Image.asset(
                  Assets.googleLogo,
                ),
              ),
              vSpace(sSecondaryPadding),
              AppButton(
                onPressed: () {},
                text: isLogin
                    ? ResLoginScreen.continueWithFacebook
                    : ResLoginScreen.signupWithFacebook,
                textColor: theme.colorScheme.primary,
                border: theme.colorScheme.primary,
                backgroundColor: Colors.transparent,
                icon: Image.asset(
                  Assets.facebookLogo,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
