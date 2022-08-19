import 'package:flutter/widgets.dart';

import '../../screens/comment_screen.dart';
import '../../screens/home_screen.dart';
import '../../screens/login_screen.dart';
import '../../screens/screens.dart';
import '../../screens/sign_up_screen.dart';
import '../../screens/splash_screen.dart';

class Routes {
  Routes._();

  static const String about = "/about";
  static const String home = "/home";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String onboarding = "/welcome";
  static const String comment = "/comment";
  static const String screens = "/screens";
  static const String splash = "/";

  static Map<String, Widget Function(BuildContext)> routes = {
    // onboarding: (context) => const OnboardingScreen(),
    home: (context) => const HomeScreen(),
    // about: (context) => const DashboardScreen(),
    login: (context) => const SignInScreen(),
    signup: (context) => const SignUpScreen(),
    comment: (context) => const CommentScreen(),
    splash: (context) => const SplashScreen(),
    screens: (context) => const Screens(),
  };
}
