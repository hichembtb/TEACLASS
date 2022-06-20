import 'package:flutter/material.dart';
import 'package:univ_app/core/utils/size_config.dart';

import '../../../../core/widgets/space_widget.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
  }) : super(key: key);
  final String? title;
  final String? subtitle;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VerticalSpace(22),
        Container(
          height: SizeConfig.screenHeight! * 0.3,
          child: Image.asset(image!),
        ),
        const VerticalSpace(8),
        Text(
          title!,
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xff2f2e41),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.left,
        ),
        const VerticalSpace(2),
        Text(
          subtitle!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Color(0xff78787c),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
