import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:univ_app/features/teacher_section/student_profile/stuent_profile_view.dart';

import '../../../constants/constants.dart';
import '../../../core/models/student_model.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/groupes_dropdown.dart';
import '../../../core/widgets/space_widget.dart';

class StudentsMark extends StatefulWidget {
  const StudentsMark({Key? key}) : super(key: key);

  @override
  State<StudentsMark> createState() => _StudentsMarkState();
}

class _StudentsMarkState extends State<StudentsMark> {
  @override
  void initState() {
    super.initState();
    dataFuture = testFunction();
  }

  late Future dataFuture;

  List<StudentModel> studentsList = [];

  List groupsListDoc = [];

  List groupsListName = [];

  Future testFunction() async {
    var groupRef = FirebaseFirestore.instance.collection('groups');
    // getting teacher's groups lenght
    var teacherRef = FirebaseFirestore.instance
        .collection('teachers')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid);
    var teacherDoc = await teacherRef.get();
    var teacherData = teacherDoc.docs;
    print("new function ");
    for (var element in teacherData) {
      groupsListDoc.addAll(element.data()['groups_list']);
      print(groupsListDoc);
      if (groupsListDoc.isNotEmpty) {
        for (var element in groupsListDoc) {
          print('testing');

          var groupDoc = groupRef.doc(element).get();
          groupDoc.then((value) => {
                print('printing the data'),
                print(value.data()!["name"]),
                groupsListName.add(value.data()!["name"]),
                print('groupslIst name : '),
                print(groupsListName),
              });
        }
      }
    }

    // End getting teacher's groups lenght
    // get the selected group

    var selectedgroup = groupe;
    if (groupe != null) {
      print('the selected groupe = $selectedgroup');
      var groupSnapshot =
          await groupRef.where('name', isEqualTo: selectedgroup).get();
      List<QueryDocumentSnapshot<Object?>> groupDoc = groupSnapshot.docs;
      for (var element in groupDoc) {
        print(element.id);
        selectedGroupDoc = element.id;
        print('==============_______________============');
        print(selectedGroupDoc);
      }

      // End get the selected group

    }

    // get student info

    List<StudentModel> studentInstance = [];

    //getStudentsFromGroupDoc
    print('the given element ID $selectedGroupDoc');
    // Get group document reference
    print("getStudentsFromGroup Called");

    // Get groupData
    var groupSnapshots = await groupRef.doc(selectedGroupDoc).get();

    if (groupSnapshots.data() == null) {
      return Future.value([]);
    }

    var studentsIDs =
        await groupSnapshots.data()!['students_list'] as List<dynamic>;

    // For each student in the student_list array get the document
    for (var studentID in studentsIDs) {
      var studentSnapshot = await FirebaseFirestore.instance
          .collection('students')
          .doc(studentID)
          .get();

      var data = studentSnapshot.data();

      print("getStudentsFromGroup data for $studentID:");
      print(data);

      // Add the student document to the list
      studentInstance.add(StudentModel.fromMap(data!));
    }
    print("getStudentsFromGroup students:");
    print(studentInstance[0].name);
    print("getStudentsFromGroup Exiting...");
    studentsList.addAll(studentInstance);
    // End getStudentsFromGroupDoc

    print('theReturn$studentInstance');
    return studentInstance;
    // end get student info
  }

  // For the drop down
  Object? groupe;

  var selectedGroupDoc;

  // For the drop down
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDashboardColor,
        toolbarHeight: SizeConfig.screenHeight! * 0.07,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(
              SizeConfig.screenWidth!,
              40.0,
            ),
          ),
        ),
        title: const Text("S T U D E N T S  M A R K"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const VerticalSpace(5),
            groupe == null
                ? const Text(
                    'select groupe',
                    style: TextStyle(fontSize: 20.0),
                  )
                : const SizedBox(),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.7,
              child: FutureBuilder<dynamic>(
                future: dataFuture,
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    case ConnectionState.done:
                    default:
                      if (snapshot.hasData) {
                        return ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SizedBox(
                                child: GroupesDropdown(
                                  value: groupe,
                                  items: groupsListName
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) async {
                                    setState(
                                      () {
                                        groupe = value;
                                        print(groupe);
                                        studentsList.removeRange(
                                            0, studentsList.length);
                                        groupsListName.removeRange(
                                            0, groupsListDoc.length);
                                        groupsListDoc.removeRange(
                                            0, groupsListDoc.length);
                                        dataFuture = testFunction();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            const VerticalSpace(4),
                            buildList(),
                          ],
                        );
                      }
                      if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else {
                        return const Text('No Data');
                      }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList() {
    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: studentsList.length,
        itemBuilder: (context, index) {
          if (studentsList.isEmpty) {
            return const Text('No data');
          }
          return ListTile(
            title: Text(
              studentsList[index].name,
              style: const TextStyle(fontSize: 15.0),
            ),
            leading: Text(
              '${studentsList[index].id}',
              style: const TextStyle(fontSize: 15.0),
            ),
            subtitle: Text(
              studentsList[index].surname,
              style: const TextStyle(fontSize: 15.0),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => StudentProfile(
                      studentName: studentsList[index].name,
                      studentSurname: studentsList[index].surname,
                    ),
                  ),
                );
              },
            ),
            // trailing: Text(studentsList[index].surname),
          );
        },
      ),
    );
  }
}
