import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/space_widget.dart';
import 'size_config.dart';

class TeacherListData extends StatefulWidget {
  const TeacherListData({Key? key}) : super(key: key);

  @override
  State<TeacherListData> createState() => _TeacherListDataState();
}

class _TeacherListDataState extends State<TeacherListData> {
  // Collection reference for teachers
  static CollectionReference teachersDataRef =
      FirebaseFirestore.instance.collection('teachers');
  // End Collection reference for teachers

  static final Stream<QuerySnapshot> _teachersStream =
      teachersDataRef.orderBy("id").snapshots();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight! * 0.7,
      child: StreamBuilder<QuerySnapshot>(
        stream: _teachersStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                //data reference
                QueryDocumentSnapshot<Object?> teachersData =
                    snapshot.data!.docs[index];
                //data reference
                return Card(
                  color: kMainColor,
                  margin: const EdgeInsets.all(4.0),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Text(
                          "${teachersData['id']}",
                          style: const TextStyle(fontSize: 20.0),
                        ),
                        const HorizintalSpace(2),
                        Text(
                          "${teachersData['name']}",
                          style: const TextStyle(fontSize: 20.0),
                        ),
                        const HorizintalSpace(2),
                        Text(
                          "${teachersData['surname']}",
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          throw UnimplementedError();
        },
      ),
    );
  }
}
