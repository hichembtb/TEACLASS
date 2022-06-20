import 'package:flutter/cupertino.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/space_widget.dart';

class AdminLoginItem extends StatelessWidget {
  const AdminLoginItem({
    Key? key,
    required this.text,
    this.inputType,
    this.maxLines,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.controller, required this.obscureText,
  }) : super(key: key);
  final String text;
  final TextInputType? inputType;
  final int? maxLines;
  final String? Function(String?)? validator;
  final ValueSetter? onSaved;
  final ValueSetter? onChanged;
  final TextEditingController? controller;
   final bool obscureText;
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
          controller: controller,
          maxLines: maxLines,
          inputType: inputType,
          validator: validator,
          onSaved: onSaved,
          onChanged: onChanged,
        )
      ],
    );
  }
}
