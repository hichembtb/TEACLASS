import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:univ_app/core/widgets/space_widget.dart';
import '../../../../constants/constants.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/custom_buttons.dart';

class UploadTimeTable extends StatefulWidget {
  const UploadTimeTable({Key? key}) : super(key: key);

  @override
  State<UploadTimeTable> createState() => _UploadTimeTableState();
}

class _UploadTimeTableState extends State<UploadTimeTable> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'timetables/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('download Link : $urlDownload');
    setState(() {
      uploadTask = null;
    });
  }

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
        title: const Text("upload time table"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (pickedFile != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(pickedFile!.name),
                ),
              const VerticalSpace(2),
              Column(
                children: [
                  CustomGeneralButton(
                    width: SizeConfig.screenWidth! * 0.2,
                    text: "select file",
                    onTap: () async {
                      if (pickedFile == null) {
                        await selectFile();
                      }
                    },
                  ),
                  const VerticalSpace(2),
                  CustomGeneralButton(
                    width: SizeConfig.screenWidth! * 0.2,
                    text: "upload file",
                    onTap: () async {
                      await uploadFile();
                    },
                  ),
                ],
              ),
              const VerticalSpace(10),
              buildProgress(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;
            return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                  Center(
                    child: Text(
                      '${(100 * progress).roundToDouble()}%',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox(
              height: 50,
            );
          }
        }),
      );
}
