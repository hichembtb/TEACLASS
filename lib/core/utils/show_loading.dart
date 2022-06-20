import 'package:flutter/material.dart';

showLoading(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(
        title: Text("Please wait"),
        content: SizedBox(
          height: 50,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    },
  );
}
