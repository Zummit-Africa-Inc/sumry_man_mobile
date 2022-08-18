import 'package:flutter/widgets.dart';

import '../../screens/comment_screen.dart';
import '../../screens/screens.dart';
import '../../screens/splash_screen.dart';

class Routes {
  Routes._();

  static String about = "/about";
  static String home = "/home";
  static String login = "/login";
  static String signup = "/signup";
  static String onboarding = "/welcome";
  static String comment = "/comment";
  static String screens = "/screens";
  static String splash = "/";

  static Map<String, Widget Function(BuildContext)> routes = {
    // onboarding: (context) => const OnboardingScreen(),
    // home: (context) => const Screens(),
    // about: (context) => const DashboardScreen(),
    // login: (context) => const ClientsScreen(),
    comment: (context) => const CommentScreen(),
    splash: (context) => const SplashScreen(),
    screens: (context) => const Screens(),
  };
}
