import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:univ_app/features/auth/presentation/manager/auth_service.dart';
import 'package:univ_app/features/dashboards/admin_dashboard/admin_dashboard_view.dart';
import '../../../../../../constants/constants.dart';
import '../../../../../../core/utils/size_config.dart';
import '../../../../../../core/widgets/custom_buttons.dart';
import '../../../../../../core/widgets/space_widget.dart';
import 'admin_login_item.dart';

class AdminLoginBody extends StatelessWidget {
  const AdminLoginBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    AuthService authService = Provider.of<AuthService>(context);
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              kMainColor,
              kDashboardColor,
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(38),
                    bottomLeft: Radius.circular(38),
                  ),
                ),
                child: ListView(
                  children: [
                    const VerticalSpace(10),
                    AdminLoginItem(
                      controller: emailController,
                      obscureText: false,
                      labelText: 'email',
                    ),
                    const VerticalSpace(2),
                    AdminLoginItem(
                      maxLines: 1,
                      controller: passwordController,
                      obscureText: true,
                      labelText: 'password',
                    ),
                    const VerticalSpace(10),
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
                              ? Get.offAll(const AdminDashboardView())
                              : null;
                        } else {
                          AwesomeDialog(
                            context: context,
                            title: "Error",
                            desc: 'you are not an Admin ',
                          ).show();
                        }
                      },
                    ),
                    const VerticalSpace(2),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight! * 0.45,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          "Admin",
                          style: TextStyle(
                            fontSize: SizeConfig.defaultSize! * 3.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Log in to Continue",
                          style: TextStyle(
                            fontSize: SizeConfig.defaultSize! * 2,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
