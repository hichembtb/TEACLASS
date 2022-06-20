import 'package:flutter/material.dart';

import 'page_view_items.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({Key? key, @required this.pageController})
      : super(key: key);
  final PageController? pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: const [
        PageViewItem(
          title: 'Easy Attendance',
          subtitle: 'Lorem epsum Lorem epsum Easy Attendance Easy Attendance ',
          image: 'assets/images/onboarding1.png',
        ),
        PageViewItem(
          title: 'Students Mark',
          subtitle: 'Lorem epsum Lorem epsum Students Mark Students Mark',
          image: 'assets/images/onboarding2.png',
        ),
        PageViewItem(
          title: 'Time Table',
          subtitle: 'Lorem epsum Lorem epsum Time Table Time Table epsum Lorem',
          image: 'assets/images/onboarding3.png',
        ),
      ],
    );
  }
}
