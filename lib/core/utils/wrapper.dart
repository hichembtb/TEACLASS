import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:univ_app/features/dashboards/admin_dashboard/admin_dashboard_view.dart';
import 'package:univ_app/features/dashboards/teacher_dashboard/teacher_dashboard_view.dart';
import 'package:univ_app/features/splash/presentation/splash_view.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const SplashView();
    }
    if (user.email == 'admin@mail.com') {
      return const AdminDashboardView();
    } else {
      return const TeacherDashboardView();
    }
  }
}
