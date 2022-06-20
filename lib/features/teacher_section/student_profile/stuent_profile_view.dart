import 'package:flutter/material.dart';

import 'widgets/student_profile_view_body.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({Key? key, this.studentName, this.studentSurname})
      : super(key: key);
  final studentName;
  final studentSurname;

  @override
  Widget build(BuildContext context) {
    return StudentProfileViewBody(
      studentName: studentName,
      studentSurname: studentSurname,
    );
  }
}
