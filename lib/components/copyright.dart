import 'package:boxy/boxy.dart';
import 'package:boxy/flex.dart';
import 'package:flutter/material.dart';
import 'package:sumry_man/utils/designs/colors.dart';

import '../utils/designs/assets.dart';
import '../utils/designs/dimens.dart';
import '../utils/res/res_profile.dart';
import 'spacers.dart';

class Copyright extends StatelessWidget {
  final Color? color;

  const Copyright({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(sPadding / 2),
        child: Text(
          '\u00a9${DateTime.now().year} ${ResWelcomePage.zummit}',
          style: theme.textTheme.bodyText2?.copyWith(
            color: color ?? theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class WebCopyright extends StatelessWidget {
  final Color? color;

  const WebCopyright({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(sPadding / 2),
        child: Text(
          '\u00a9${DateTime.now().year} ${ResWelcomePage.zummit}',
          style: theme.textTheme.bodyText2?.copyWith(
            color: kWhite,
          ),
        ),
      ),
    );
  }
}

class Trademark extends StatelessWidget {
  const Trademark({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomBoxy(
      delegate: _TrademarkDelegate(),
      children: [
        BoxyId(
          id: #name,
          child: RichText(
            text: TextSpan(
              style: theme.textTheme.headline4?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              children: <TextSpan>[
                const TextSpan(text: 'Sumry'),
                TextSpan(
                  text: 'Man',
                  style: TextStyle(color: theme.colorScheme.secondary),
                ),
              ],
            ),
          ),
        ),
        BoxyId(
          id: #logo,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'by',
                style: theme.textTheme.bodyText2?.copyWith(
                  color: Colors.white,
                ),
              ),
              hSpace(sSecondaryPadding / 2),
              Image.asset(Assets.zummitLogo),
            ],
          ),
        ),
      ],
    );
  }
}

class _TrademarkDelegate extends BoxyDelegate {
  @override
  Size layout() {
    final name = getChild(#name);
    final logo = getChild(#logo);

    final nameSize = name.layout(constraints);
    final logoSize = logo.layout(constraints);

    name.position(Offset.zero);
    logo.position(Offset(nameSize.width - logoSize.width, nameSize.height));

    return Size(
      nameSize.width,
      nameSize.height,
    );
  }
}
