import 'package:flutter/cupertino.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/space_widget.dart';

class TeacherLoginItem extends StatelessWidget {
  const TeacherLoginItem({
    Key? key,
    required this.text,
    this.inputType,
    this.maxLines,
    required this.obscureText,
    this.controller,
  }) : super(key: key);
  final String text;
  final TextInputType? inputType;
  final int? maxLines;
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
          textAlign: TextAlign.center,
        ),
        const VerticalSpace(2),
        CustomTextFormField(
          obscureText: obscureText,
          maxLines: maxLines,
          inputType: inputType,
          onSaved: (value) {},
          controller: controller,
        )
      ],
    );
  }
}
