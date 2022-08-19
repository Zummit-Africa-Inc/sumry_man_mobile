import 'package:flutter/material.dart';

import '../utils/designs/colors.dart';

class InputField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final int? maxLines;
  final bool expands;
  final IconData? icon;
  final bool readOnly;

  const InputField({
    Key? key,
    this.controller,
    required this.label,
    this.maxLines,
    this.icon,
    this.expands = false,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      expands: expands,
      readOnly: readOnly,
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
        suffixIcon: icon != null ? Icon(icon) : null,
      ),
      maxLines: maxLines,
    );
  }
}
