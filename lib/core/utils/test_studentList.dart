import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:univ_app/core/widgets/filiers_dropdown.dart';
import 'package:univ_app/core/widgets/groupes_dropdown.dart';
import 'package:univ_app/core/widgets/space_widget.dart';
import '../models/student_model.dart';
import 'size_config.dart';

class TestPersonelStudentList extends StatefulWidget {
  const TestPersonelStudentList({Key? key, this.onTap}) : super(key: key);
  final VoidCallback? onTap;
  @override
  State<TestPersonelStudentList> createState() => _StudentListDataState();
}

class _StudentListDataState extends State<TestPersonelStudentList> {
  @override
  void initState() {
    super.initState();
    dataFuture = testFunction();
  }

  late Future dataFuture;

  List<StudentModel> studentsList = [];

  List groupsListDoc = [];
  List groupsListName = [];
  String filierDoc = '';

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
      // Filier Test
      filierDoc = element.data()['filier'];
      print('==========Filier Test=======================');
      print(filierDoc);
      CollectionReference filiesrRef =
          FirebaseFirestore.instance.collection('filiers');
      List groupsListFromFilier = [];

      await filiesrRef.doc(filierDoc).get().then(
            (value) => {
              groupsListFromFilier = value.get('groups_list'),
              print(groupsListFromFilier),
              print('==========Filier Test Ending ======================='),
            },
          );

      //  End Filier Test
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
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
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
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              child: FilierDropDown(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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
                          buildDataTable(),
                        ],
                      );
                    }
                    if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else {
                      return const Text('default');
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  int? sortColumnIndex;
  bool isAscending = false;
  Widget buildDataTable() {
    final columns = ['id', 'name', 'surname', 'test 1', 'test 2', 'MOY'];
    return DataTable(
      columnSpacing: SizeConfig.screenWidth! * 0.005,
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: getColumns(columns),
      rows: getRows(studentsList),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map(
        (String column) => DataColumn(
          label: Text(column),
          onSort: onSort,
        ),
      )
      .toList();
  List<DataRow> getRows(List<StudentModel> students) => students.map(
        (StudentModel student) {
          final cells = [
            student.id,
            student.name,
            student.surname,
            '1',
            '1',
            '1'
          ];
          return DataRow(cells: getCells(cells));
        },
      ).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells
      .map(
        (data) => DataCell(
          Text('$data'),
          onLongPress: () {},
        ),
      )
      .toList();
  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      studentsList.sort(
        (student1, student2) => compareId(ascending, student1.id, student2.id),
      );
    } else if (columnIndex == 1) {
      studentsList.sort(
        (student1, student2) =>
            compareString(ascending, student1.name, student2.name),
      );
    } else if (columnIndex == 2) {
      studentsList.sort(
        (student1, student2) =>
            compareString(ascending, student1.surname, student2.surname),
      );
    }
    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
  int compareId(bool ascending, int value1, int value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
