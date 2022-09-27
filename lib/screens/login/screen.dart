import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/app_bar.dart';
import '../../components/drawer.dart';
import '../../utils/designs/routes.dart';
import 'form.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: DefaultAppBar(
        trailing: GestureDetector(
          onTap: () => Navigator.pushNamed(context, Routes.home),
          child: Text(
            'Skip',
            style: theme.textTheme.caption?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: const SafeArea(
        child: LoginForm(),
      ),
    );
  }
}
