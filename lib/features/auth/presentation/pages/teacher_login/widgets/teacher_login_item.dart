import 'package:flutter/cupertino.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/space_widget.dart';

class TeacherLoginItem extends StatelessWidget {
  const TeacherLoginItem({
    Key? key,
    this.inputType,
    this.maxLines,
    required this.obscureText,
    this.controller,
    required this.labelText,
  }) : super(key: key);

  final TextInputType? inputType;
  final int? maxLines;
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
          labelText: labelText,
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
