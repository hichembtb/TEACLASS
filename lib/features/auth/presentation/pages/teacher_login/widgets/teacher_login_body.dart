import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univ_app/features/dashboards/teacher_dashboard/teacher_dashboard_view.dart';
import '../../../../../../core/widgets/custom_buttons.dart';
import '../../../../../../core/widgets/space_widget.dart';
import '../../../manager/auth_service.dart';
import 'teacher_login_item.dart';

class TeacherLoginBody extends StatelessWidget {
  const TeacherLoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    AuthService authService = Provider.of<AuthService>(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          const VerticalSpace(10),
          const Text(
            'Teacher',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const VerticalSpace(10),
          TeacherLoginItem(
            controller: emailController,
            obscureText: false,
            text: 'Mail',
          ),
          const VerticalSpace(2),
          TeacherLoginItem(
            maxLines: 1,
            controller: passwordController,
            obscureText: true,
            text: 'Password',
          ),
          const VerticalSpace(5),
          CustomGeneralButton(
            text: 'Login',
            onTap: () async {
              if (emailController.text != 'admin@mail.com') {
                var teacher = await authService.logInEmailPassword(
                  context,
                  emailController.text,
                  passwordController.text,
                );
                teacher != null
                    ? Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const TeacherDashboardView(),
                        ),
                      )
                    : null;
              } else {
                AwesomeDialog(
                  context: context,
                  title: "Error",
                  desc: 'Admin cant access teacher Section',
                ).show();
              }
            },
          )
        ],
      ),
    );
  }
}
