import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:univ_app/core/utils/size_config.dart';
import 'package:univ_app/core/widgets/custom_buttons.dart';
import 'package:univ_app/core/widgets/space_widget.dart';
import 'package:univ_app/features/admin_section/forums/student_forum/widgets/student_forum_item.dart';

class StudentProfileViewBody extends StatefulWidget {
  const StudentProfileViewBody({
    Key? key,
    this.studentName,
    this.studentSurname,
  }) : super(key: key);
  final studentName;
  final studentSurname;
  @override
  State<StudentProfileViewBody> createState() => _StudentProfileViewBodyState();
}

class _StudentProfileViewBodyState extends State<StudentProfileViewBody> {
  TextEditingController test1Controller = TextEditingController();
  TextEditingController test2Controller = TextEditingController();
  double max = 0, moy = 0;
  double? moyGen = 0;
  double? maxTest() {
    double test1 = double.parse(test1Controller.text);
    double test2 = double.parse(test2Controller.text);
    test1 < test2 ? max = test2 : max = test1;
    print(max);
    moyGen = max;
    return moyGen;
  }

  double? moyTest() {
    double test1 = double.parse(test1Controller.text);
    double test2 = double.parse(test2Controller.text);
    moy = (test1 + test2) / 2;
    print(moy);
    moyGen = moy;
    return moyGen;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const VerticalSpace(2),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.studentName,
                          style: const TextStyle(fontSize: 30.0),
                        ),
                        const VerticalSpace(1.5),
                        Text(
                          widget.studentSurname,
                          style: const TextStyle(fontSize: 30.0),
                        ),
                      ],
                    ),
                    const HorizintalSpace(10),
                    CircleAvatar(
                      backgroundColor: moyGen == 0.0
                          ? Colors.white
                          : moyGen! < 10
                              ? Colors.red
                              : Colors.green,
                      radius: SizeConfig.defaultSize! * 4,
                      child: Text(
                        '$moyGen',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 30.0, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const VerticalSpace(5),
            StudentForumItem(
              text: 'test 1 ',
              obscureText: false,
              inputType: TextInputType.number,
              controller: test1Controller,
            ),
            const VerticalSpace(2),
            StudentForumItem(
              text: 'test 2 ',
              obscureText: false,
              inputType: TextInputType.number,
              controller: test2Controller,
            ),
            const VerticalSpace(2),
            Column(
              children: [
                CustomGeneralButton(
                  text: 'Max',
                  width: SizeConfig.screenWidth! * 0.3,
                  onTap: () {
                    setState(() {
                      maxTest();
                    });
                  },
                ),
                const VerticalSpace(2),
                CustomGeneralButton(
                  text: 'Moy',
                  width: SizeConfig.screenWidth! * 0.3,
                  onTap: () {
                    setState(
                      () {
                        moyTest();
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
