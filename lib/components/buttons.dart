import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repository/user_repository.dart';
import '../screens/login/form.dart';
import '../screens/login/screen.dart';
import '../utils/designs/dimens.dart';
import '../utils/designs/routes.dart';
import '../utils/res/res_profile.dart';
import 'spacers.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final String text;
  final EdgeInsets? padding;
  final Widget? icon;
  final Color? border;

  const AppButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.icon,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        padding: padding ?? const EdgeInsets.all(8),
        backgroundColor: backgroundColor ?? theme.colorScheme.secondary,
        side: BorderSide(color: border != null ? border! : Colors.transparent),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sSecondaryPadding / 2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...{
            icon!,
            hSpace(sSecondaryPadding / 2),
          },
          Text(
            isLoading ? 'please wait...' : text,
            style: theme.textTheme.button?.copyWith(
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class LoginRegisterButton extends ConsumerWidget {
  final bool isLargeScreen;
  const LoginRegisterButton({super.key, this.isLargeScreen = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(userRepository.notifier);
    return repo.authenticated
        ? const SizedBox()
        : AppButton(
            text: ResHomeScreen.loginRegister,
            onPressed: () {
              if (isLargeScreen) {
                showDialog(
                  context: context,
                  builder: (ctx) => const LoginForm(),
                );
              } else {
                Navigator.pushNamed(context, Routes.login);
              }
            },
            textColor: Theme.of(context).colorScheme.primary,
          );
  }
}
