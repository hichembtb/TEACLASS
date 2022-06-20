import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:univ_app/constants/constants.dart';
import 'package:univ_app/core/models/student_model.dart';
import 'package:univ_app/core/widgets/space_widget.dart';
import 'package:univ_app/features/admin_section/forums/student_forum/widgets/student_forum_item.dart';

class StudentForumBody extends StatefulWidget {
  const StudentForumBody({Key? key}) : super(key: key);

  @override
  State<StudentForumBody> createState() => _StudentForumBodyState();
}

class _StudentForumBodyState extends State<StudentForumBody> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  // Collection reference for students
  CollectionReference studentsRef =
      FirebaseFirestore.instance.collection('students');
  // End Collection reference for students

  // Collection reference for groups
  static CollectionReference groupsRef =
      FirebaseFirestore.instance.collection('groups');

  // End Collection reference for groups
  // Student Info
  int id = 0;
  var name;
  var surname;
  var birthday;
  var adresse;
  var phone;
  static var group;
  // End Student Info

  // Add Student Function
  addStudent() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      formData.save();
      QuerySnapshot<Object?> groupeByName =
          await groupsRef.where('name', isEqualTo: group).get();
      List<QueryDocumentSnapshot> groupeList = groupeByName.docs;
      for (var element in groupeList) {
        var selectedGroupDocForStudent = element.id;
        final student = StudentModel(
          id: id,
          name: name,
          surname: surname,
          birth: birthday,
          adress: adresse,
          group: group,
        );

        final json = student.toJson();
        await studentsRef.doc().set(json);

        var studentDocById =
            await studentsRef.where('id', isEqualTo: student.id).get();
        List<QueryDocumentSnapshot> studentDoc = studentDocById.docs;
        for (var element in studentDoc) {
          List studentDocToAdd = [];
          studentDocToAdd.add(element.id);
          groupsRef.doc(selectedGroupDocForStudent).update(
              {'students_list': FieldValue.arrayUnion(studentDocToAdd)});
        }

        Navigator.pop(context);
      }
    }
  }
  // End Add Student Function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: const Text("Student Forum"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () async {
                await addStudent();
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
                StudentForumItem(
                  obscureText: false,
                  text: 'id',
                  inputType: TextInputType.number,
                  onSaved: (value) {
                    id = int.parse(value);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please insert student ID";
                    }
                    return null;
                  },
                ),
                const VerticalSpace(2),
                StudentForumItem(
                  obscureText: false,
                  text: 'nom',
                  inputType: TextInputType.name,
                  onSaved: (value) {
                    name = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please insert student Name";
                    }
                    return null;
                  },
                ),
                const VerticalSpace(2),
                StudentForumItem(
                  obscureText: false,
                  text: 'prenom',
                  inputType: TextInputType.name,
                  onSaved: (value) {
                    surname = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please insert student surname";
                    }
                    return null;
                  },
                ),
                const VerticalSpace(2),
                StudentForumItem(
                  obscureText: false,
                  text: 'date de naissance',
                  inputType: TextInputType.datetime,
                  onSaved: (value) {
                    birthday = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please insert student birthday";
                    }
                    return null;
                  },
                ),
                const VerticalSpace(2),
                StudentForumItem(
                  obscureText: false,
                  text: 'Adresse',
                  inputType: TextInputType.emailAddress,
                  onSaved: (value) {
                    adresse = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please insert student adress";
                    }
                    return null;
                  },
                ),
                const VerticalSpace(2),
                const VerticalSpace(2),
                StudentForumItem(
                  obscureText: false,
                  text: 'groupe',
                  inputType: TextInputType.number,
                  onSaved: (value) {
                    group = 'groupe$value';
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please insert student's group";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
