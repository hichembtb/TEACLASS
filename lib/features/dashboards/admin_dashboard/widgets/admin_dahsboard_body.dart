import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univ_app/constants/constants.dart';
import 'package:univ_app/core/utils/size_config.dart';
import 'package:univ_app/core/widgets/custom_dash_buttons.dart';
import 'package:univ_app/features/admin_section/students_list/students_list_view.dart';
import 'package:univ_app/features/admin_section/teachers-list/teachers_list_view.dart';
import 'package:univ_app/features/admin_section/time_table/time_table_view.dart';
import 'package:univ_app/features/auth/presentation/pages/login/login_view.dart';
import '../../../auth/presentation/manager/auth_service.dart';

class AdminDashboardBody extends StatefulWidget {
  const AdminDashboardBody({Key? key}) : super(key: key);

  @override
  State<AdminDashboardBody> createState() => _AdminDashboardBodyState();
}

class _AdminDashboardBodyState extends State<AdminDashboardBody> {
  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDashboardColor,
        toolbarHeight: SizeConfig.screenHeight! * 0.07,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(
              SizeConfig.screenWidth!,
              40.0,
            ),
          ),
        ),
        title: const Text("A D M I N"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: SizeConfig.screenHeight! * 0.1,
              spacing: SizeConfig.defaultSize! * 5,
              children: [
                CustomDashButton(
                  text: 'Teachers',
                  image: kTeachers,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TeachersListView(),
                      ),
                    );
                  },
                ),
                CustomDashButton(
                  text: 'Students',
                  image: kStudents,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StudentsListView(),
                      ),
                    );
                  },
                ),
                CustomDashButton(
                  text: 'Time Table',
                  image: kTimtable,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TimeTableView(),
                      ),
                    );
                  },
                ),
                CustomDashButton(
                  text: 'Log out',
                  image: kLogout,
                  onTap: () async {
                    var admin = await authService.signOut();
                    admin == null
                        ? Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LoginView(),
                            ),
                          )
                        : null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
