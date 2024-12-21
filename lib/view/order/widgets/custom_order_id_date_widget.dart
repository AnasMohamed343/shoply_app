import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';

class CustomOrderIdDateWidget extends StatelessWidget {
  IconData icon;
  String title, subTitle;
  CustomOrderIdDateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(
          width: 10.w,
        ),
        Column(
          children: [
            Text(
              title,
              style: Styles.textStyle14.copyWith(color: kGreyColor),
            ),
            Text(
              subTitle,
              style: Styles.textStyle16,
            ),
          ],
        ),
      ],
    );
  }
}
