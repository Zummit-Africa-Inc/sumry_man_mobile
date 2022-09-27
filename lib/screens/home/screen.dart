import 'package:flutter/material.dart';
import 'package:sumry_man/components/copyright.dart';
import 'package:sumry_man/utils/designs/colors.dart';
import 'package:sumry_man/utils/designs/styles.dart';

import '../../components/app_bar.dart';
import '../../components/buttons.dart';
import '../../components/drawer.dart';
import '../../components/spacers.dart';
import '../../utils/designs/assets.dart';
import '../../utils/designs/dimens.dart';
import '../../utils/res/res_profile.dart';
import '../about_screen.dart';
import 'fields.dart';

class HomeScreen extends StatelessWidget {
  final bool isLargeScreen;

  const HomeScreen(this.isLargeScreen, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final padding =
        isLargeScreen ? MediaQuery.of(context).size.width * 0.05 : sPadding;

    final headerText = Text(
      ResHomeScreen.header,
      style:
          (isLargeScreen ? textTheme.headline2 : textTheme.headline5)?.copyWith(
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.primary,
      ),
    );
    final text = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isLargeScreen
            ? headerText
            : FractionallySizedBox(
                widthFactor: 0.6,
                child: headerText,
              ),
        vSpace(isLargeScreen ? sSecondaryPadding * 2 : sSecondaryPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                isLargeScreen
                    ? ResHomeScreen.subHeaderLarge
                    : ResHomeScreen.subHeader,
                style:
                    (isLargeScreen ? textTheme.headline5 : textTheme.overline)
                        ?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            if (isLargeScreen) ...{
              Expanded(
                flex: 2,
                child: Image.asset(
                  Assets.welcome2,
                ),
              ),
            }
          ],
        )
      ],
    );
    final largeTop = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: text),
        hSpace(padding),
        const Expanded(child: HomeFields()),
      ],
    );

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: DefaultAppBar(
        title: isLargeScreen
            ? Padding(
                padding: EdgeInsets.only(left: padding),
                child: const TrademarkText(),
              )
            : null,
        trailing: const LoginRegisterButton(),
        padding: padding,
        color: isLargeScreen ? theme.colorScheme.primary : null,
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          controller: PrimaryScrollController.of(context),
          children: [
            vSpace(padding),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: isLargeScreen ? largeTop : text,
            ),
            isLargeScreen
                ? AboutContent(
                    isLargeScreen: isLargeScreen,
                    padding: padding,
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: const HomeFields(),
                  ),
            isLargeScreen
                ? Container(
                    padding: EdgeInsets.symmetric(
                      vertical: sPadding,
                      horizontal: padding,
                    ),
                    color: theme.colorScheme.primary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Trademark(),
                        Copyright(
                          isLargeScreen: isLargeScreen,
                          color: Colors.white,
                          italics: true,
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
