import 'package:flutter/material.dart';

import '../../../core/utils/size_config.dart';
import 'widgets/teacher_dashboard_body.dart';

class TeacherDashboardView extends StatelessWidget {
  const TeacherDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const TeacherDashboardBody();
  }
}
