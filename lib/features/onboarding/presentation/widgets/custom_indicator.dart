import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({Key? key, @required this.dotIndex}) : super(key: key);
  final double? dotIndex;
  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      decorator: const DotsDecorator(
        activeColor: Color(0xff5A38FD),
      ),
      dotsCount: 3,
      position: dotIndex!,
    );
  }
}
