import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  Size get screenSize {
    return MediaQuery.of(this).removePadding().size;
  }

  void showSnackMessage(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
