import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/copyright.dart';
import '../components/spacers.dart';
import '../data/repository/user_repository.dart';
import '../utils/designs/assets.dart';
import '../utils/designs/dimens.dart';
import '../utils/designs/routes.dart';
import '../utils/res/res_profile.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    Future.delayed(
      const Duration(seconds: 2),
      () {
        final repo = ref.read(userRepository.notifier);
        Navigator.pushReplacementNamed(
          context,
          repo.authenticated ? Routes.home : Routes.onboarding,
        );
      },
    );
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Image(
              image: AssetImage(Assets.sumryLogo),
            ),
            vSpace(sPadding),
            Text(
              ResWelcomePage.sumry,
              style: theme.textTheme.headline4?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            const Copyright(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
