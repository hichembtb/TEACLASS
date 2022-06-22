import 'package:flutter/material.dart';
import 'package:univ_app/core/widgets/custom_text_field.dart';
import 'package:univ_app/core/widgets/space_widget.dart';

class StudentForumItem extends StatelessWidget {
  const StudentForumItem({
    Key? key,
    this.inputType,
    this.onSaved,
    this.validator,
    required this.obscureText,
    this.controller,
    required this.labelText,
  }) : super(key: key);

  final TextInputType? inputType;
  final ValueSetter? onSaved;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextEditingController? controller;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VerticalSpace(2),
        CustomTextFormField(
          obscureText: obscureText,
          inputType: inputType,
          onSaved: onSaved,
          validator: validator,
          controller: controller,
          labelText: labelText,
        )
      ],
    );
  }
}
