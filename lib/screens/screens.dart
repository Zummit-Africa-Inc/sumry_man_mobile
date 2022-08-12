import 'package:flutter/material.dart';

import '../components/copyright.dart';
import '../utilis/designs/routes.dart';

/// Should only be used for debugging
class Screens extends StatelessWidget {
  const Screens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routes = Routes.routes.keys;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screens'),
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: routes.length,
            itemBuilder: (_, i) => GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(routes.elementAt(i));
              },
              child: Text(
                routes.elementAt(i),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          const Spacer(),
          const Copyright(),
        ],
      ),
    );
  }
}
