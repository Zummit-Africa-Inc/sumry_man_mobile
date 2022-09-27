import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/buttons.dart';
import '../../components/input_field.dart';
import '../../components/or.dart';
import '../../components/spacers.dart';
import '../../utils/designs/assets.dart';
import '../../utils/designs/colors.dart';
import '../../utils/designs/dimens.dart';
import '../../utils/res/res_profile.dart';
import 'state.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(loginState);
    final isLogin = state.state == LoginScreenState.login;

    return Material(
      child: Form(
        key: form,
        child: ListView(
          shrinkWrap: true,
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
                isLogin ? ResLoginScreen.subHeader1 : ResLoginScreen.subHeader2,
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
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return 'Name cannot be empty';
                    }
                    return null;
                  },
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
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Email cannot be empty';
                  }
                  return null;
                },
              ),
            ),
            vSpace(sPadding),
            PasswordField(
              state: InputFieldState(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Password cannot be empty';
                  }
                  return null;
                },
              ),
            ),
            if (!isLogin) ...{
              vSpace(sPadding),
              PasswordField(
                state: InputFieldState(
                  label: ResLoginScreen.confirmPassword,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value != passwordController.text) {
                      return 'Passwords not the same';
                    }
                    return null;
                  },
                ),
              ),
            },
            vSpace(sPadding * 2),
            AppButton(
              isLoading: state.isLoginLoading,
              onPressed: () => state.onLoginClick(
                form: form,
                ref: ref,
                nameController: nameController,
                emailController: emailController,
                passwordController: passwordController,
                context: context,
              ),
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
                  onTap: () => state.change(ref),
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
              isLoading: state.isGoogleLoading,
              onPressed: () => state.onGoogleClick(ref, context),
              text: isLogin
                  ? ResLoginScreen.continueWithGoogle
                  : ResLoginScreen.signupWithGoogle,
              backgroundColor: theme.colorScheme.primary,
              icon: Image.asset(
                Assets.googleLogo,
              ),
            ),
            // vSpace(sSecondaryPadding),
            // AppButton(
            //   isLoading: state.isFacebookLoading,
            //   onPressed: () => state.onFacebookClick(ref, context),
            //   text: isLogin
            //       ? ResLoginScreen.continueWithFacebook
            //       : ResLoginScreen.signupWithFacebook,
            //   textColor: theme.colorScheme.primary,
            //   border: theme.colorScheme.primary,
            //   backgroundColor: Colors.transparent,
            //   icon: Image.asset(
            //     Assets.facebookLogo,
            //   ),
            // ),
          ],
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
