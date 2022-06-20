import 'package:flutter/material.dart';
import 'package:univ_app/core/widgets/custom_text_field.dart';
import 'package:univ_app/core/widgets/space_widget.dart';

class TeacherForumItem extends StatelessWidget {
  const TeacherForumItem(
      {Key? key,
      required this.text,
      this.inputType,
      required String? Function(dynamic value) validator,
      this.onSaved, required this.obscureText, this.controller})
      : super(key: key);
  final String text;
  final TextInputType? inputType;
  final ValueSetter? onSaved;
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
          controller: controller,
          obscureText: obscureText,
          inputType: inputType,
          onSaved: onSaved,
        )
      ],
    );
  }
}
