import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/copyright.dart';
import '../data/repository/user_repository.dart';
import '../utils/designs/routes.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    Future.delayed(
      const Duration(seconds: 2),
      () {
        final repo = ref.read(userRepository.notifier);
        Navigator.pushReplacementNamed(
          context,
          repo.authenticated ? Routes.home : Routes.onboarding,
        );
      },
    );
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Spacer(),
          Trademark(),
          Spacer(),
          Copyright(color: Colors.white),
        ],
      ),
    );
  }
}
