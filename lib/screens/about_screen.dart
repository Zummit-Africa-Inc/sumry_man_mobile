// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../components/app_bar.dart';
import '../components/buttons.dart';
import '../components/copyright.dart';
import '../components/drawer.dart';
import '../components/spacers.dart';
import '../utils/designs/assets.dart';
import '../utils/designs/dimens.dart';
import '../utils/res/res_profile.dart';

class AboutScreen extends StatelessWidget {
  final bool isLargeScreen;
  final double padding;

  const AboutScreen({
    Key? key,
    required this.isLargeScreen,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isLargeScreen
          ? null
          : DefaultAppBar(
              trailing: LoginRegisterButton(),
            ),
      drawer: isLargeScreen ? null : const AppDrawer(),
      body: SafeArea(
        child: AboutContent(
          isLargeScreen: isLargeScreen,
          padding: padding,
        ),
      ),
    );
  }
}

class AboutContent extends StatelessWidget {
  final bool isLargeScreen;
  final double padding;
  const AboutContent({
    super.key,
    required this.isLargeScreen,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final text = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLargeScreen ? ResAboutScreen.titleBig : ResAboutScreen.titleSmall,
          style: (isLargeScreen ? textTheme.headline3 : textTheme.headline5)
              ?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
          ),
        ),
        vSpace(sSecondaryPadding),
        Text(
          ResAboutScreen.body,
          style: (isLargeScreen ? textTheme.headline5 : textTheme.bodyText2)
              ?.copyWith(
            color: isLargeScreen ? theme.colorScheme.primary : null,
            height: isLargeScreen ? 2.125 : 1.64,
          ),
        ),
      ],
    );

    final content = isLargeScreen
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Center(
                  child: Image.asset(Assets.aboutLarge),
                ),
              ),
              hSpace(padding * 2),
              Flexible(
                child: text,
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text,
              Spacer(),
              Expanded(
                flex: 2,
                child: Center(
                  child: Image.asset(Assets.about),
                ),
              ),
              Spacer(),
              Copyright()
            ],
          );

    return Container(
        color: isLargeScreen ? Color(0xFFFFFEF5) : Colors.transparent,
        padding: EdgeInsets.fromLTRB(
          padding,
          padding,
          padding,
          isLargeScreen ? padding : 0,
        ),
        child: content);
  }
}
