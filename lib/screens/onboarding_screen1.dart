import 'package:flutter/material.dart';
import 'package:sumry_app/utilis/designs/assets.dart';
import 'package:sumry_app/utilis/designs/colors.dart';
import 'package:sumry_app/utilis/designs/styles.dart';
class Onboarding1 extends StatelessWidget {
  const Onboarding1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(85, 130, 85, 60),
            height: 300,
            width: 200,
            child: Image.asset(Assets.welcome),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 0, 0, 5),
            width: 300,
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 230,
                  height: 120,

                  child: Text(
                    'Summarize Urls and Texts',
                    style: sOnboarding1MainTextStyle,
                  ),
                ),
                Text(
                  'Support for input from different sources(eg. url(website), text input)',
                  style: sOnboarding1subTextStyle,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Next',
                style: sOnboardingButtonTextStyle),
              SizedBox(
                width: 5,
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: InkWell(
                      onTap: (){},
                      child: Image.asset(Assets.nextIcon))),
            ],
          )
        ],
      ),
    );
  }
}
