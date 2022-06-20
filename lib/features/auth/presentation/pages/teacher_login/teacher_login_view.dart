import 'package:flutter/material.dart';

import 'widgets/teacher_login_body.dart';

class TeacherLoginView extends StatelessWidget {
  const TeacherLoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TeacherLoginBody(),
    );
  }
}
