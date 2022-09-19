// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import '../utils/designs/dimens.dart';
import '../utils/designs/styles.dart';
import '../utils/res/res_profile.dart';

@immutable
class InputFieldState {
  final TextEditingController? controller;
  final Function()? onClick;
  final String label;
  final Widget? icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final bool isInputUnderline;
  final int? maxLines;
  final String? Function(String?)? validator;
  final bool expands;
  final TextInputAction? textInputAction;
  final TextAlign textAlign;

  InputFieldState({
    this.controller,
    this.onClick,
    this.label = '',
    this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.isInputUnderline = true,
    this.maxLines,
    this.expands = false,
    this.textInputAction,
    this.validator,
    this.textAlign = TextAlign.start,
  });

  InputFieldState copyWith({
    TextEditingController? controller,
    Function()? onClick,
    String? label,
    Widget? icon,
    TextInputType? keyboardType,
    bool? obscureText,
    bool? readOnly,
    bool? isInputUnderline,
    int? maxLines,
    bool? expands,
    TextInputAction? textInputAction,
    TextAlign? textAlign,
    String? Function(String?)? validator,
  }) =>
      InputFieldState(
        controller: controller ?? this.controller,
        onClick: onClick ?? this.onClick,
        label: label ?? this.label,
        icon: icon ?? this.icon,
        keyboardType: keyboardType ?? this.keyboardType,
        obscureText: obscureText ?? this.obscureText,
        readOnly: readOnly ?? this.readOnly,
        isInputUnderline: isInputUnderline ?? this.isInputUnderline,
        maxLines: maxLines ?? this.maxLines,
        expands: expands ?? this.expands,
        textInputAction: textInputAction ?? this.textInputAction,
        textAlign: textAlign ?? this.textAlign,
        validator: validator ?? this.validator,
      );
}

class InputField extends StatelessWidget {
  final InputFieldState state;

  InputField({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      textAlign: state.textAlign,
      controller: state.controller,
      expands: state.expands,
      onTap: state.onClick,
      readOnly: state.readOnly,
      cursorColor: theme.colorScheme.primary,
      textInputAction: state.textInputAction,
      keyboardType: state.keyboardType,
      obscureText: state.obscureText,
      decoration: InputDecoration(
        hintText: state.label,
        hintStyle: sHintTextStyle,
        contentPadding: state.readOnly == false
            ? const EdgeInsets.symmetric(
                horizontal: sSecondaryPadding,
                vertical: sSecondaryPadding / 2,
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(sSecondaryPadding / 2),
          ),
          borderSide: BorderSide(
            color: theme.colorScheme.secondary,
            width: 1.4,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(sSecondaryPadding / 2),
          ),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 1.4,
          ),
        ),
        suffixIcon: state.icon,
      ),
      maxLines: state.maxLines,
    );
  }
}

class PasswordField extends StatefulWidget {
  final InputFieldState state;

  const PasswordField({Key? key, required this.state}) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    final state = widget.state;

    return InputField(
      state: state.copyWith(
        label: (state.label.isEmpty) ? ResMisc.password : state.label,
        obscureText: _obscured,
        keyboardType: TextInputType.visiblePassword,
        maxLines: 1,
        icon: GestureDetector(
          onTap: () {
            _obscured = _obscured ? false : true;
            setState(() {});
          },
          child: Icon(
            _obscured ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
    );
  }
}

class DropdownTextField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final Function(T?) onItemChanged;
  final String? Function(T?)? validator;

  const DropdownTextField({
    Key? key,
    this.value,
    this.validator,
    required this.items,
    required this.label,
    required this.onItemChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          label,
          style: theme.textTheme.overline,
        ),
        DropdownButtonFormField(
          value: value,
          validator: validator,
          items: items
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item.toString(),
                    style: theme.textTheme.bodyText2
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              )
              .toList(),
          onChanged: onItemChanged,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
          ),
          style:
              theme.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
