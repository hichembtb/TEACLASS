import 'package:flutter/material.dart';
import 'package:univ_app/core/widgets/custom_text_field.dart';
import 'package:univ_app/core/widgets/space_widget.dart';

class TeacherForumItem extends StatelessWidget {
  const TeacherForumItem(
      {Key? key,
      this.inputType,
      required String? Function(dynamic value) validator,
      this.onSaved,
      required this.obscureText,
      this.controller,
      required this.labelText})
      : super(key: key);

  final TextInputType? inputType;
  final ValueSetter? onSaved;
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
          controller: controller,
          obscureText: obscureText,
          inputType: inputType,
          onSaved: onSaved,
          labelText: labelText,
        )
      ],
    );
  }
}
