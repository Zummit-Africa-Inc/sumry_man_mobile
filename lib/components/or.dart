import 'package:flutter/material.dart';

import '../utils/designs/dimens.dart';
import '../utils/res/res_profile.dart';

class Or extends StatelessWidget {
  const Or({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        const Expanded(
          child: Divider(
            thickness: 2.0,
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: sSecondaryPadding / 2),
          child: Text(
            ResMisc.or,
            style: theme.textTheme.button?.copyWith(
              color: Colors.black,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            thickness: 2.0,
          ),
        ),
      ],
    );
  }
}
