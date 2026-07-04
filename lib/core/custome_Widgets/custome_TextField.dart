import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomeTextfield extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String labletext;
  final IconData iconData;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputformaters;
  final TextInputType? keybordtype;
  final AutovalidateMode? autovalidateMode;
  final ValueChanged<String>? onChanged;
  const CustomeTextfield({
    required this.controller,
    required this.obscureText,
    required this.labletext,
    required this.iconData,
    required this.validator,
    this.inputformaters,
    this.keybordtype,
    this.autovalidateMode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: keybordtype,
      autovalidateMode: autovalidateMode,
      inputFormatters: inputformaters,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: labletext,
        prefixIcon: Icon(iconData),
        border: OutlineInputBorder(),
      ),
    );
  }
}
