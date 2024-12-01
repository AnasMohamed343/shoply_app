import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/core/common/widgets/custom_container_linear_admin.dart';

class DashboardItem extends StatelessWidget {
  final String title, number, image;
  const DashboardItem(
      {super.key,
      required this.title,
      required this.number,
      required this.image});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return CustomContainerLinearAdmin(
      width: w,
      height: h * 0.17,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  title,
                  style: Styles.textStyle24,
                ),
                const Spacer(),
                Text(
                  number,
                  style: Styles.textStyle24,
                ),
                const Spacer(),
              ],
            ),
            SizedBox(
              width: w * 0.2,
              height: h * 0.1,
              child: SvgPicture.asset(image),
            ),
          ],
        ),
      ),
    );
  }
}
