import 'package:flutter/material.dart';

import '../utilis/designs/dimens.dart';
import '../utilis/res/res_profile.dart';

class Copyright extends StatelessWidget {
  final Color color;

  const Copyright({
    Key? key,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(sPadding / 2),
        child: Text(
          '@${DateTime.now().year} ${ResWelcomePage.zummit}',
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: color,
              ),
        ),
      ),
    );
  }
}
