import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utils/designs/colors.dart';
import 'utils/designs/routes.dart';

void main() {
  runApp(const SumryMan());
}

class SumryMan extends StatelessWidget {
  const SumryMan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light(
          primary: kPrimaryColor,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context)
              .textTheme
              .apply(
                displayColor: kTextColor,
                bodyColor: kTextColor,
              )
              .copyWith(button: GoogleFonts.inter()),
        ),
      ),
      routes: Routes.routes,
    );
  }
}
