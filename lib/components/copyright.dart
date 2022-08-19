import 'package:flutter/material.dart';

import '../utils/designs/dimens.dart';
import '../utils/res/res_profile.dart';

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
