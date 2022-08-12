import 'package:flutter/material.dart';

import '../components/copyright.dart';
import '../components/spacers.dart';
import '../utilis/designs/assets.dart';
import '../utilis/designs/dimens.dart';
import '../utilis/designs/routes.dart';
import '../utilis/res/res_profile.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.pushReplacementNamed(
        context,
        Routes.screens,
      ),
    );
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image(
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
