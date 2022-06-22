import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:univ_app/core/widgets/custom_buttons.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late Future futureData;
  @override
  void initState() {
    futureData = getData();
    super.initState();
  }

  String uid = 'bKTHcYreTXYK1j5IHz8o8jSaJEB3';

  var moduleDocument;
  var note;
  Future getData() async {
    CollectionReference moduleRef =
        FirebaseFirestore.instance.collection('module');
    var moduleDoc = await moduleRef
        .where('uid', isEqualTo: uid //FirebaseAuth.instance.currentUser!.uid,
            )
        .get();

    var moduleList = moduleDoc.docs;
    for (var element in moduleList) {
      moduleDocument = element.id;
      print(moduleDocument);
    }
    CollectionReference notesRef =
        moduleRef.doc(moduleDocument).collection('notes');

    var notesDoc = await notesRef.get();

    for (var element in notesDoc.docs) {
      note = element.data();
      print(element.data()!);
    }
    return note;
  }

  updateNote(String? newNote) async {
    CollectionReference moduleRef =
        FirebaseFirestore.instance.collection('module');
    var moduleDoc = await moduleRef
        .where('uid', isEqualTo: uid //FirebaseAuth.instance.currentUser!.uid,
            )
        .get();

    var moduleList = moduleDoc.docs;
    for (var element in moduleList) {
      moduleDocument = element.id;
      print(moduleDocument);
    }
    CollectionReference notesRef =
        moduleRef.doc(moduleDocument).collection('notes');

    var notesDoc = await notesRef.get();

    for (var element in notesDoc.docs) {
      setState(() {
        notesRef.doc(element.id).set({
          'note': newNote,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 150,
          width: double.infinity,
          child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Text('${note['note']}'),
                      CustomGeneralButton(
                        text: 'add',
                        onTap: () {
                          updateNote(50.toString());
                        },
                      )
                    ],
                  );
                }
                return const Text('No data');
              }),
        ),
      ),
    );
  }
}
