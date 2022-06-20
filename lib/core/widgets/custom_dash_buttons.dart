import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../utils/size_config.dart';

class CustomDashButton extends StatelessWidget {
  const CustomDashButton({
    Key? key,
    required this.text,
    this.onTap,
    required this.image,
  }) : super(key: key);
  final String? text;
  final VoidCallback? onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 20,
        children: [
          Container(
            height: SizeConfig.screenHeight! * 0.15,
            width: SizeConfig.screenWidth! * 0.40,
            decoration: BoxDecoration(
              color: kMainColor,
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: Text(
              text!,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
