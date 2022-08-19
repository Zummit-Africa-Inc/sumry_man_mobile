import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/spacers.dart';
import '../utils/designs/assets.dart';
import '../utils/designs/dimens.dart';
import '../utils/designs/routes.dart';
import '../utils/res/res_profile.dart';

final _pageProvider = StateProvider((_) => true);

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  void _switch(WidgetRef ref) {
    final state = ref.read(_pageProvider.state);
    state.state = !state.state;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final first = ref.watch(_pageProvider);
    return WillPopScope(
      onWillPop: () async {
        if (first) {
          return true;
        } else {
          _switch(ref);
          return false;
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: sPadding,
            vertical: sPadding * 2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Image.asset(
                  first ? Assets.welcome1 : Assets.welcome2,
                ),
              ),
              vSpace(sPadding * 3.5),
              Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  child: Text(
                    first
                        ? ResOnboardingScreen.title1
                        : ResOnboardingScreen.title2,
                    style: theme.textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              vSpace(sSecondaryPadding / 2),
              Text(
                first ? ResOnboardingScreen.body1 : ResOnboardingScreen.body2,
                style: theme.textTheme.bodyText1,
              ),
              vSpace(sPadding * 2.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    first
                        ? ResOnboardingScreen.next1
                        : ResOnboardingScreen.next2,
                    style: theme.textTheme.button?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  hSpace(sSecondaryPadding / 2),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: theme.colorScheme.secondary,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                    ),
                    child: Icon(
                      Icons.navigate_next,
                      color: theme.colorScheme.primary,
                    ),
                    onPressed: () {
                      if (first) {
                        _switch(ref);
                      } else {
                        Navigator.pushNamed(context, Routes.home);
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
