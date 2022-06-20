import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:univ_app/core/models/admin_model.dart';
import 'package:univ_app/core/utils/show_loading.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  AdminModel? _adminFromFirebase(auth.User? admin) {
    if (admin == null) {
      return null;
    }
    return AdminModel(admin.email!, admin.uid);
  }

  Stream<AdminModel?>? get admin {
    return _firebaseAuth.authStateChanges().map(_adminFromFirebase);
  }

  // Log in with email and password
  Future logInEmailPassword(
      BuildContext context, String email, password) async {
    try {
      showLoading(context);
      auth.UserCredential adminCredential =
          await auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return adminCredential.user;
    } on auth.FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      e.code == 'user-not-found'
          ? AwesomeDialog(
              context: context,
              title: "Error",
              desc: 'user not found.',
            ).show()
          : null;

      e.code == 'wrong-password'
          ? AwesomeDialog(
              context: context,
              title: "Error",
              desc: 'Wrong password provided.',
            ).show()
          : null;
    } catch (e) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Internet Problem "),
            content: Container(
              height: 50,
            ),
          );
        },
      );
    }
  }
  //End  Log in with email and password

  // Signout
  Future signOut() async {
    return await _firebaseAuth.signOut();
  }
  // End Signout

  // Create Teacher with Email and Password
  Future createTacher(BuildContext context, String email, password) async {
    try {
      showLoading(context);
      auth.UserCredential teacherCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(teacherCredential.user);
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  // End Create Teacher with Email and Password
}
