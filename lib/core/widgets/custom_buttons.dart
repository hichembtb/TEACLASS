import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../utils/size_config.dart';
import 'space_widget.dart';

class CustomGeneralButton extends StatelessWidget {
  const CustomGeneralButton({
    Key? key,
    required this.text,
    this.height,
    this.width,
    this.onTap,
  }) : super(key: key);
  final String? text;
  final VoidCallback? onTap;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 60,
        width: width ?? SizeConfig.screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [kDashboardColor, kDashboardColor.withOpacity(0.5)],
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(5, 5),
              blurRadius: 10,
            )
          ],
        ),
        child: Center(
          child: Text(
            text!,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

//
//
class CustomButtonWithIcon extends StatelessWidget {
  const CustomButtonWithIcon(
      {Key? key, required this.text, this.onTap, this.iconData, this.color})
      : super(key: key);
  final String text;
  final IconData? iconData;
  final VoidCallback? onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: color,
            ),
            const HorizintalSpace(2),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                fontSize: 13,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
