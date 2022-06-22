import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:univ_app/constants/constants.dart';
import 'package:univ_app/core/utils/size_config.dart';
import 'package:univ_app/core/widgets/custom_buttons.dart';
import 'package:univ_app/core/widgets/space_widget.dart';
import '../../../manager/auth_service.dart';
import 'teacher_login_item.dart';
import '../../../../../dashboards/teacher_dashboard/teacher_dashboard_view.dart';

class TeacherLoginBody extends StatelessWidget {
  const TeacherLoginBody({Key? key}) : super(key: key);
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
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.45,
                  child: Image.asset(kSplash),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        "Hi Teacher",
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
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(38),
                    topLeft: Radius.circular(38),
                  ),
                ),
                child: ListView(
                  children: [
                    TeacherLoginItem(
                      controller: emailController,
                      obscureText: false,
                      labelText: 'email',
                    ),
                    const VerticalSpace(2),
                    TeacherLoginItem(
                      maxLines: 1,
                      controller: passwordController,
                      obscureText: true,
                      labelText: 'password',
                    ),
                    const VerticalSpace(10),
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
                              ? Get.offAll(const TeacherDashboardView())
                              : null;
                        } else {
                          AwesomeDialog(
                            context: context,
                            title: "Error",
                            desc: 'Admin cant access teacher Section',
                          ).show();
                        }
                      },
                    ),
                    const VerticalSpace(2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
