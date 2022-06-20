import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univ_app/features/auth/presentation/manager/auth_service.dart';
import 'package:univ_app/features/dashboards/admin_dashboard/admin_dashboard_view.dart';
import '../../../../../../core/widgets/custom_buttons.dart';
import '../../../../../../core/widgets/space_widget.dart';
import 'admin_login_item.dart';

class AdminLoginBody extends StatefulWidget {
  const AdminLoginBody({Key? key}) : super(key: key);

  @override
  State<AdminLoginBody> createState() => _AdminLoginBodyState();
}

class _AdminLoginBodyState extends State<AdminLoginBody> {
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
            'Admin',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const VerticalSpace(10),
          AdminLoginItem(
            obscureText: false,
            text: 'Mail',
            inputType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return "no email adresse";
              }
              return null;
            },
            controller: emailController,
          ),
          const VerticalSpace(2),
          AdminLoginItem(
            obscureText: true,
            text: 'Password',
            maxLines: 1,
            validator: (value) {
              if (value!.isEmpty) {
                return "enter password";
              }
              return null;
            },
            controller: passwordController,
          ),
          const VerticalSpace(5),
          CustomGeneralButton(
            text: 'Login',
            onTap: () async {
              if (emailController.text == 'admin@mail.com') {
                var admin = await authService.logInEmailPassword(
                  context,
                  emailController.text,
                  passwordController.text,
                );
                admin != null
                    ? Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const AdminDashboardView(),
                        ),
                      )
                    : null;
              } else {
                AwesomeDialog(
                  context: context,
                  title: "Error",
                  desc: 'you are not an Admin ',
                ).show();
              }
            },
          )
        ],
      ),
    );
  }
}
