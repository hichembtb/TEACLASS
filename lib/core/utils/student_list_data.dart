import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../widgets/space_widget.dart';
import 'size_config.dart';

class StudentListData extends StatefulWidget {
  const StudentListData({Key? key, this.onTap}) : super(key: key);
  final VoidCallback? onTap;
  @override
  State<StudentListData> createState() => _StudentListDataState();
}

class _StudentListDataState extends State<StudentListData> {
  // Collection reference for students
  static CollectionReference studentsRef =
      FirebaseFirestore.instance.collection('students');
  // End Collection reference for students

  // Students list Stream
  static final Stream<QuerySnapshot> _studentsStream =
      studentsRef.orderBy('id').snapshots();
  // End Students list Stream

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight! * 0.7,
      child: StreamBuilder<QuerySnapshot>(
        stream: _studentsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                //data reference
                QueryDocumentSnapshot<Object?> studentData =
                    snapshot.data!.docs[index];
                //data reference
                return GestureDetector(
                  onTap: widget.onTap,
                  child: Card(
                    color: kMainColor,
                    margin: const EdgeInsets.all(4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Text(
                            "${studentData['id']}",
                            style: const TextStyle(fontSize: 20.0),
                          ),
                          const HorizintalSpace(2),
                          Text(
                            "${studentData['name']}",
                            style: const TextStyle(fontSize: 20.0),
                          ),
                          const HorizintalSpace(2),
                          Text(
                            "${studentData['surname']}",
                            style: const TextStyle(fontSize: 20.0),
                          ),
                          const HorizintalSpace(2),
                        ],
                      ),
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
