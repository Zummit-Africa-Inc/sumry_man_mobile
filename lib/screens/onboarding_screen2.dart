import 'package:flutter/material.dart';

import '../utils/designs/assets.dart';
import '../utils/designs/styles.dart';
import '../utils/res/res_profile.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image(
                image: AssetImage(Assets.upload),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ResOnboardingScreen2.title,
                    style: sOnBoarding2BigText,
                  ),
                  Text(
                    ResOnboardingScreen2.body,
                    style: sOnBoarding2SmallText,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    ResOnboardingScreen2.getStarted,
                    style: sButtonTextStyle,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      print('button clicked');
                    },
                    child: Image(
                      image: AssetImage(Assets.next),
                      height: 40,
                      width: 40,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

