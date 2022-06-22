import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType? inputType;
  final Widget? suffexIcon;
  final ValueSetter? onSaved;
  final ValueSetter? onChanged;
  final int? maxLines;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool obscureText;
  final String labelText;
  const CustomTextFormField({
    Key? key,
    @required this.inputType,
    this.suffexIcon,
    @required this.onSaved,
    this.onChanged,
    this.maxLines,
    this.validator,
    this.controller,
    required this.obscureText,
    required this.labelText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      keyboardType: inputType,
      onChanged: onChanged,
      onSaved: onSaved,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
        ),
        labelStyle: TextStyle(
          color: Colors.black.withOpacity(0.8),
        ),
      ),
    );
  }
}
