import 'package:flutter/material.dart';

class TeacherPresInfo extends StatelessWidget {
  const TeacherPresInfo({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20.0),
    );
  }
}
