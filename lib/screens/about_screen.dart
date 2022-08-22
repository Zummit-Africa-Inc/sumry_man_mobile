// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sumry_app/components/copyright.dart';

import '../components/app_bar.dart';
import '../components/buttons.dart';
import '../components/drawer.dart';
import '../components/spacers.dart';
import '../utils/designs/dimens.dart';
import '../utils/res/res_profile.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: DefaultAppBar(
        trailing: AppButton(
          text: ResHomeScreen.loginRegister,
          onPressed: () {},
          textColor: theme.colorScheme.primary,
        ),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(sPadding, sPadding, sPadding, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ResAboutScreen.title,
                style: theme.textTheme.headline5?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
              vSpace(sSecondaryPadding),
              Text(ResAboutScreen.body),
              Spacer(),
              Expanded(
                flex: 2,
                child: Center(
                  child: Image.asset(
                    "assets/images/about_img.png",
                  ),
                ),
              ),
              Spacer(),
              Copyright()
            ],
          ),
        ),
      ),
    );
  }
}
