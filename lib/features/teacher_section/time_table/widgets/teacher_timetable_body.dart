import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class TeacherTimeTableViewBody extends StatefulWidget {
  const TeacherTimeTableViewBody({Key? key}) : super(key: key);

  @override
  State<TeacherTimeTableViewBody> createState() =>
      _TeacherTimeTableViewBodyState();
}

class _TeacherTimeTableViewBodyState extends State<TeacherTimeTableViewBody> {
  late Future<ListResult> futureFiles;
  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance.ref('/timetables').listAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Tables List'),
      ),
      body: SafeArea(
        child: FutureBuilder<ListResult>(
          future: futureFiles,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              final files = snapshot.data!.items;
              return ListView.builder(
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final file = files[index];
                  return ListTile(
                    title: Text(file.name),
                    trailing: IconButton(
                      onPressed: () {
                        downloadFile(file);
                      },
                      icon: const Icon(Icons.download),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('error occurred'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
    );
  }

  Future downloadFile(Reference ref) async {
    final url = await ref.getDownloadURL();

    final path = '/storage/emulated/0/Download/${ref.name}';

    await Dio().download(url, path);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Download ${ref.name}'),
      ),
    );
  }
}
