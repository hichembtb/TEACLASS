import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:univ_app/constants/constants.dart';
import 'package:univ_app/core/utils/size_config.dart';
import 'package:univ_app/core/widgets/space_widget.dart';

class TeacherProfileViewBody extends StatefulWidget {
  const TeacherProfileViewBody({Key? key}) : super(key: key);

  @override
  State<TeacherProfileViewBody> createState() => _TeacherProfileViewBodyState();
}

class _TeacherProfileViewBodyState extends State<TeacherProfileViewBody> {
  late Future getTeacher;

  @override
  void initState() {
    super.initState();
    getTeacher = getData();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> teacherRef = FirebaseFirestore
      .instance
      .collection('teachers')
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();
  CollectionReference groupRef =
      FirebaseFirestore.instance.collection('groups');
  var groupName = [];
  var teacherInfo = [];

  Future getData() async {
    var result = teacherRef.then(
      (value) => {
        value.docs.forEach(
          (element) {
            teacherInfo.addAll({element.data()});
            for (var element in teacherInfo) {
              element['groups_list'].forEach((val) async {
                var groupData = await groupRef.doc(val).get();
                setState(() {
                  groupName.add(groupData['name']);
                });

                print('groupName    $groupName');
              });
            }
          },
        ),
      },
    );

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getTeacher,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: const AssetImage(kTeacherProfile),
                        radius: SizeConfig.defaultSize! * 10,
                      ),
                      const VerticalSpace(2),
                      Text(
                        '${teacherInfo[0]['name']}',
                        style: const TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                      const VerticalSpace(1),
                      Text(
                        '${teacherInfo[0]['surname']}',
                        style: const TextStyle(fontSize: 25.0),
                      ),
                      const VerticalSpace(4),
                      const Text(
                        'my groups',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20.0),
                      ),
                      const VerticalSpace(1),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.4,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: groupName.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Text('${groupName[index]}'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
