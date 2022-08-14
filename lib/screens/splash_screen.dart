import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sumry_app/components/spacers.dart';
import 'package:sumry_app/screens/onboarding_screen1.dart';
import 'package:sumry_app/utilis/designs/assets.dart';
import 'package:sumry_app/utilis/designs/styles.dart';
import 'package:sumry_app/utilis/res/res_profile.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}


class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 6),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                Onboarding1()
            )
        )
    );
  }
  final double space = 18;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(Assets.sumryLogo),
            ),
            vSpace(space),
            Text(
              ResWelcomePage.sumry,
              style: sPrimaryTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
