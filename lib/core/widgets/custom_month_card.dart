import 'package:flutter/material.dart';
import 'package:univ_app/constants/constants.dart';

class CustomMonthCard extends StatelessWidget {
  const CustomMonthCard({
    Key? key,
    required this.child,
    this.width,
    this.horizontalMargin = 20,
    this.verticalMargin = 5,
    this.horizontaPadding = 20,
    this.verticalPadding = 20,
    this.onTap,
  }) : super(key: key);
  final Widget child;
  final double? width;
  final double horizontalMargin;
  final double verticalMargin;
  final double horizontaPadding;
  final double verticalPadding;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: width,
          margin: EdgeInsets.symmetric(
              vertical: verticalMargin, horizontal: horizontalMargin),
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontaPadding),
          decoration: BoxDecoration(
            color: kMainColor,
            boxShadow: [
              boxShadow(),
            ],
            borderRadius: BorderRadius.circular(7),
            // image: const DecorationImage(
            //   image: AssetImage(kLogo),
            //   fit: BoxFit.cover,
            // ),
          ),
          child: child),
    );
  }
}

BoxShadow boxShadow() {
  return BoxShadow(
    color: Colors.grey.withOpacity(0.3),
    spreadRadius: 0.5,
    blurRadius: 0.5,
    offset: const Offset(0, 0), // changes position of shadow
  );
}
