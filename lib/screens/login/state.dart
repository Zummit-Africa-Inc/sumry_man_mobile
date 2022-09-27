import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumry_man/utils/extensions.dart';

import '../../data/repository/user_repository.dart';
import '../../utils/designs/routes.dart';

enum LoginScreenState { login, signup }

final _state = StateProvider.autoDispose((ref) => LoginScreenState.login);
final _isLoginLoading = StateProvider.autoDispose((ref) => false);
final _isGoogleLoading = StateProvider.autoDispose((ref) => false);
final _isFacebookLoading = StateProvider.autoDispose((ref) => false);

final loginState = Provider.autoDispose((ref) {
  return LoginState(
    ref.watch(_state),
    ref.watch(_isLoginLoading),
    ref.watch(_isGoogleLoading),
    ref.watch(_isFacebookLoading),
  );
});

class LoginState {
  final LoginScreenState state;
  final bool isLoginLoading, isGoogleLoading, isFacebookLoading;

  const LoginState(
    this.state,
    this.isLoginLoading,
    this.isGoogleLoading,
    this.isFacebookLoading,
  );

  void change(WidgetRef ref) {
    LoginScreenState newState;
    if (state == LoginScreenState.login) {
      newState = LoginScreenState.signup;
    } else {
      newState = LoginScreenState.login;
    }
    ref.read(_state.notifier).state = newState;
  }

  void onLoginClick({
    required GlobalKey<FormState> form,
    required WidgetRef ref,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required BuildContext context,
  }) async {
    if (form.currentState?.validate() == true) {
      ref.read(_isLoginLoading.notifier).state = true;
      final repository = ref.read(userRepository.notifier);
      final name = nameController.text;
      final email = emailController.text;
      final password = passwordController.text;
      final result = state == LoginScreenState.login
          ? repository.login(email, password)
          : repository.register(name, email, password);
      result.then((value) {
        ref.read(_isLoginLoading.notifier).state = false;
        _handleResult(value, context);
      });
    }
  }

  void onGoogleClick(WidgetRef ref, BuildContext context) async {
    ref.read(_isGoogleLoading.notifier).state = true;
    final repository = ref.read(userRepository.notifier);
    repository.signInWithGoogle().then((value) {
      ref.read(_isGoogleLoading.notifier).state = false;
      _handleResult(value, context);
    });
  }

  void onFacebookClick(WidgetRef ref, BuildContext context) async {
    ref.read(_isFacebookLoading.notifier).state = true;
    final repository = ref.read(userRepository.notifier);
    repository.signInWithFacebook().then((value) {
      ref.read(_isFacebookLoading.notifier).state = false;
      _handleResult(value, context);
    });
  }

  void _handleResult(String? result, BuildContext context) {
    if (result == null) {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.home, ModalRoute.withName(Routes.splash));
    } else {
      context.showSnackMessage(result);
    }
  }
}
