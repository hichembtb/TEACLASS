import 'package:flutter/material.dart';
import 'package:univ_app/constants/constants.dart';
import 'package:univ_app/core/utils/size_config.dart';
import 'package:univ_app/core/utils/teacher_list_data.dart';
import 'package:univ_app/core/widgets/branche_dropdown.dart';
import 'package:univ_app/core/widgets/groupes_dropdown.dart';
import 'package:univ_app/core/widgets/parcour_dropdown.dart';
import 'package:univ_app/core/widgets/space_widget.dart';
import '../../forums/teacher_forum/teacher_forum_view.dart';

class TeachersListBody extends StatefulWidget {
  const TeachersListBody({Key? key}) : super(key: key);

  @override
  State<TeachersListBody> createState() => _TeachersListBodyState();
}

class _TeachersListBodyState extends State<TeachersListBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const TeacherForumView(),
            ),
          );
        },
        backgroundColor: kDashboardColor,
        child: const Icon(Icons.add),
      ),
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
        title: const Text("Teachers List "),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: ListView(
            children: const [
              VerticalSpace(5),
              TeacherListData(),
            ],
          ),
        ),
      ),
    );
  }
}
