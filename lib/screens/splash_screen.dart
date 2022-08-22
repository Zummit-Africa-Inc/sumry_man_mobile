import 'package:flutter/material.dart';

import '../components/copyright.dart';
import '../components/spacers.dart';
import '../utils/designs/assets.dart';
import '../utils/designs/dimens.dart';
import '../utils/designs/routes.dart';
import '../utils/res/res_profile.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.pushReplacementNamed(
        context,
        Routes.onboarding,
      ),
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
