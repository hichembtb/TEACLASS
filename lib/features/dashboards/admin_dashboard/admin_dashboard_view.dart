import 'package:flutter/material.dart';

import '../../../core/utils/size_config.dart';
import 'widgets/admin_dahsboard_body.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      SizeConfig().init(context);
    return const AdminDashboardBody();
  }
}
