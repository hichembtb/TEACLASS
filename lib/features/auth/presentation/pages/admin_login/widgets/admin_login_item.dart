import 'package:flutter/cupertino.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/space_widget.dart';

class AdminLoginItem extends StatelessWidget {
  const AdminLoginItem({
    Key? key,
   
    this.inputType,
    this.maxLines,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.controller,
    required this.obscureText,
    required this.labelText,
  }) : super(key: key);
 
  final TextInputType? inputType;
  final int? maxLines;
  final String? Function(String?)? validator;
  final ValueSetter? onSaved;
  final ValueSetter? onChanged;
  final TextEditingController? controller;
  final bool obscureText;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        const VerticalSpace(2),
        CustomTextFormField(
          obscureText: obscureText,
          controller: controller,
          maxLines: maxLines,
          inputType: inputType,
          validator: validator,
          onSaved: onSaved,
          onChanged: onChanged,
          labelText: labelText,
        )
      ],
    );
  }
}
