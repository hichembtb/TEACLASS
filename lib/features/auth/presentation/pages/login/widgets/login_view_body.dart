import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:univ_app/features/auth/presentation/pages/admin_login/admin_login_view.dart';
import '../../../../../../constants/constants.dart';
import '../../../../../../core/utils/size_config.dart';
import '../../../../../../core/widgets/custom_buttons.dart';
import '../../../../../../core/widgets/space_widget.dart';
import '../../teacher_login/teacher_login_view.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VerticalSpace(15),
        SizedBox(
          height: SizeConfig.defaultSize! * 25,
          width: double.infinity,
          child: Image.asset(
            kLogo,
            fit: BoxFit.fill,
          ),
        ),
        const VerticalSpace(5),
        Text(
          'YOU ARE ',
          style: TextStyle(
            fontSize: 41.0,
            fontWeight: FontWeight.w600,
            color: Colors.blue.shade900,
          ),
        ),
        const Expanded(child: SizedBox()),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomButtonWithIcon(
                text: 'Admin',
                color: const Color(0xFFdb3236),
                iconData: FontAwesomeIcons.adn,
                onTap: () async {
                  Get.off(const AdminLoginView());
                },
              ),
            ),
            const VerticalSpace(2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomButtonWithIcon(
                text: 'Teacher',
                color: const Color(0xFF4267B2),
                iconData: FontAwesomeIcons.chalkboardUser,
                onTap: () async {
                  Get.off(const TeacherLoginView());
                },
              ),
            ),
          ],
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}
