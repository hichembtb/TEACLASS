import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univ_app/constants/constants.dart';
import 'package:univ_app/core/models/checkBox_model.dart';
import 'package:univ_app/core/models/teacher_model.dart';
import 'package:univ_app/core/widgets/space_widget.dart';
import 'package:univ_app/features/auth/presentation/manager/auth_service.dart';
import 'teacher_forum_item.dart';

class TeacherForumBody extends StatefulWidget {
  const TeacherForumBody({Key? key}) : super(key: key);

  @override
  State<TeacherForumBody> createState() => _TeacherForumBodyState();
}

class _TeacherForumBodyState extends State<TeacherForumBody> {
  List checkBoxList = [];
  List selectedGroups = [];
  createGroupsCheck() {
    for (int i = 1; i <= 3; i++) {
      checkBoxList.add(
        CheckBoxModel(
          title: 'groupe$i',
          value: false,
        ),
      );
    }
  }

  @override
  void initState() {
    createGroupsCheck();
    super.initState();
  }

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  // Collection reference for Teacher
  CollectionReference teachersRef =
      FirebaseFirestore.instance.collection('teachers');
  // End Collection reference for Teacher

  // Collection reference for groups
  static CollectionReference groupsRef =
      FirebaseFirestore.instance.collection('groups');

  // End Collection reference for groups
  // Teacher Info
  var id;
  var name;
  var surname;
  var groupe;

  // End Teacher Info

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context);
    // Add Teacher Function
    addTeacher() async {
      var formData = formState.currentState;
      if (formData!.validate()) {
        formData.save();
        QuerySnapshot<Object?> groupeByName =
            await groupsRef.where('name', whereIn: selectedGroups).get();
        List<QueryDocumentSnapshot> groupeList = groupeByName.docs;

        List<String> groupDocToAdd = [];
        for (var element in groupeList) {
          groupDocToAdd.add(element.id);
        }
        final teacher = TeacherModel(id, name, surname, groupDocToAdd,
            FirebaseAuth.instance.currentUser!.uid);

        final json = teacher.toJson();
        await teachersRef.doc().set(json);
      }
    }

    addTeacherAuth() async {
      await authService.createTacher(
          context, emailController.text, passwordController.text);
    }

    // End Add Teacher Function
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: const Text("Teacher Forum"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () async {
                await addTeacherAuth();
                await addTeacher();

                // ignore: use_build_context_synchronously
                await authService.logInEmailPassword(
                    context, 'admin@mail.com', 'admin123');
              },
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formState,
            child: ListView(
              children: [
                const VerticalSpace(2),
                TeacherForumItem(
                  labelText: 'id',
                  obscureText: false,
                  inputType: TextInputType.number,
                  onSaved: (value) {
                    id = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please insert teacher ID";
                    }
                    return null;
                  },
                ),
                const VerticalSpace(2),
                TeacherForumItem(
                  labelText: 'nom',
                  obscureText: false,
                  inputType: TextInputType.name,
                  onSaved: (value) {
                    name = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please insert teacher Name";
                    }
                    return null;
                  },
                ),
                const VerticalSpace(2),
                TeacherForumItem(
                  labelText: 'prenom',
                  obscureText: false,
                  inputType: TextInputType.name,
                  onSaved: (value) {
                    surname = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please insert teacher surname";
                    }
                    return null;
                  },
                ),
                TeacherForumItem(
                  labelText: 'email',
                  obscureText: false,
                  inputType: TextInputType.name,
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please insert teacher email";
                    }
                    return null;
                  },
                ),
                TeacherForumItem(
                  labelText: 'password',
                  obscureText: false,
                  inputType: TextInputType.name,
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please insert teacher password";
                    }
                    return null;
                  },
                ),
                const VerticalSpace(2),
                const Divider(),
                buildCheckBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCheckBox() {
    return SizedBox(
      child: ListView(
        shrinkWrap: true,
        children: [
          ...checkBoxList.map(
            (item) => ListTile(
              leading: Checkbox(
                value: item.value,
                onChanged: (value) {
                  print(value);
                  if (value == false) {
                    selectedGroups.remove(item.title);
                  } else {
                    if (!selectedGroups.contains(item.title)) {
                      selectedGroups.add(item.title);
                      print(selectedGroups);
                    }
                  }

                  onItemClick(item);
                },
              ),
              title: Text(
                item.title!,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  onAllClicked(CheckBoxModel checkItem) {
    final newValue = !checkItem.value!;
    setState(() {
      checkItem.value = !checkItem.value!;
      for (var element in checkBoxList) {
        element.value = newValue;
      }
    });
  }

  onItemClick(CheckBoxModel checkItem) {
    setState(() {
      checkItem.value = !checkItem.value!;
    });
  }
}
