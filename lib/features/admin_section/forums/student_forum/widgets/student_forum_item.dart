import 'package:flutter/material.dart';
import 'package:univ_app/core/widgets/custom_text_field.dart';
import 'package:univ_app/core/widgets/space_widget.dart';

class StudentForumItem extends StatelessWidget {
  const StudentForumItem(
      {Key? key,
      required this.text,
      this.inputType,
      this.onSaved,
      this.validator,
      required this.obscureText,
      this.controller})
      : super(key: key);
  final String text;
  final TextInputType? inputType;
  final ValueSetter? onSaved;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: Color(0xff0c0b0b),
            fontWeight: FontWeight.w600,
            height: 1.5625,
          ),
          textHeightBehavior:
              const TextHeightBehavior(applyHeightToFirstAscent: false),
        ),
        const VerticalSpace(2),
        CustomTextFormField(
          obscureText: obscureText,
          inputType: inputType,
          onSaved: onSaved,
          validator: validator,
          controller: controller,
        )
      ],
    );
  }
}
