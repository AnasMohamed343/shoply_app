import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';

class CustomNotificationItem extends StatelessWidget {
  final String title, body, date, image;
  const CustomNotificationItem(
      {super.key,
      required this.title,
      required this.body,
      required this.date,
      required this.image});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 0.15,
      width: w,
      margin: EdgeInsetsDirectional.symmetric(
        horizontal: w * 0.02,
      ),
      padding: EdgeInsetsDirectional.symmetric(
        vertical: h * 0.02,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: w * 0.01),
          Stack(
            children: [
              CircleAvatar(
                radius: w * 0.1,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: NetworkImage(image),
                child: null,
              ),
            ],
          ),
          SizedBox(width: w * 0.05),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Styles.textStyle16,
              ),
              SizedBox(height: h * 0.005),
              Text(
                body,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Styles.textStyle16.copyWith(fontSize: 15),
              ),
              SizedBox(height: h * 0.01),
              Text(
                date.substring(0, 16),
                style: Styles.textStyle12.copyWith(color: kGreyColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
