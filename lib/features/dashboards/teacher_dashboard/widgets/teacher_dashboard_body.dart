import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univ_app/constants/constants.dart';
import 'package:univ_app/core/utils/size_config.dart';
import 'package:univ_app/core/widgets/custom_buttons.dart';
import 'package:univ_app/core/widgets/custom_dash_buttons.dart';
import 'package:univ_app/core/widgets/space_widget.dart';
import 'package:univ_app/features/teacher_section/attendance/attendance_view.dart';
import 'package:univ_app/features/teacher_section/students_mark/students_mark.dart';
import 'package:univ_app/features/teacher_section/teacher_profile/teacher_profile_view.dart';
import 'package:univ_app/features/teacher_section/time_table/teacher_timetable_view.dart';

import '../../../auth/presentation/manager/auth_service.dart';
import '../../../auth/presentation/pages/login/login_view.dart';

class TeacherDashboardBody extends StatelessWidget {
  const TeacherDashboardBody({Key? key}) : super(key: key);

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
              50.0,
            ),
          ),
        ),
        title: const Text("T E A C H E R"),
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
                  text: 'Attendance',
                  image: kAttendance,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AttendanceView(),
                      ),
                    );
                  },
                ),
                CustomDashButton(
                  text: 'Students Mark',
                  image: kStudentsmark,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const StudentsMark(),
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
                        builder: (context) => const TeacherTimeTableView(),
                      ),
                    );
                  },
                ),
                CustomDashButton(
                  text: 'My Profile',
                  image: kTeachers,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TeacherProfileView(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const VerticalSpace(10),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomGeneralButton(
              text: 'Log out',
              onTap: () async {
                var teacher = await authService.signOut();
                teacher == null
                    ? Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                      )
                    : null;
              },
            ),
          )
        ],
      ),
    );
  }
}
