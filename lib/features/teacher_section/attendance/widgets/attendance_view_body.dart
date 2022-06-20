import 'package:flutter/material.dart';
import 'package:univ_app/core/widgets/space_widget.dart';
import '../../../../constants/constants.dart';
import '../../../../core/utils/personel_students_list.dart';
import '../../../../core/utils/size_config.dart';

class AttendanceViewBody extends StatefulWidget {
  const AttendanceViewBody({Key? key}) : super(key: key);

  @override
  State<AttendanceViewBody> createState() => _AttendanceViewBodyState();
}

class _AttendanceViewBodyState extends State<AttendanceViewBody> {
  @override
  Widget build(BuildContext context) {
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
        title: const Text("My Students List "),
      ),
      body: SafeArea(
        child: ListView(
          children: const [
            VerticalSpace(2),
            PersonelStudentList(),
          ],
        ),
      ),
    );
  }
}
