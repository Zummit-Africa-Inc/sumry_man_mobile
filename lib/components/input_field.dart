import 'package:flutter/material.dart';

import '../utils/designs/colors.dart';

class InputField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final int? maxLines;
  final bool expands;

  const InputField({
    Key? key,
    this.controller,
    required this.label,
    this.maxLines,
    this.expands = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      expands: expands,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
          ),
        ),
        label: Text(
          label,
          style: theme.textTheme.caption?.copyWith(
            color: kInputHintColor,
          ),
        ),
      ),
      maxLines: maxLines,
    );
  }
}