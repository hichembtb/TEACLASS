import 'package:flutter/material.dart';
import 'widgets/admin_login_body.dart';

class AdminLoginView extends StatelessWidget {
  const AdminLoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AdminLoginBody(),
    );
  }
}
