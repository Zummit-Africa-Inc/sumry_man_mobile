import 'package:flutter/material.dart';
import 'package:sumry_app/models/pages.dart';
import 'package:sumry_app/screens/login_screen.dart';
import 'package:sumry_app/screens/sign_up_screen.dart';
import 'package:sumry_app/screens/splash_screen.dart';
import 'package:sumry_app/utilis/designs/colors.dart';

void main() {
  runApp(const SumryMan());
}

class SumryMan extends StatelessWidget {
  const SumryMan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      // home: const SignUpScreen(),
      initialRoute: SumryManApp.signUpPath,
      routes: {
        SumryManApp.signUpPath: (context) => const SignUpScreen(),
        SumryManApp.signInPath: (context) => const SignInScreen(),
      },
    );
  }
}
