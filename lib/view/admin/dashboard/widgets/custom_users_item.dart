import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';

class CustomUsersItem extends StatelessWidget {
  final String userName, userEmail, userPicture;
  const CustomUsersItem(
      {super.key, required this.userName, required this.userEmail, required this.userPicture});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        vertical: h * 0.03,
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
                backgroundImage:  NetworkImage(
                  userPicture
                ),
                child: null,
              ),
            ],
          ),
          SizedBox(width: w * 0.05),
          Column(
            children: [
              Text(
                userName, // Replace with default static name
                style: Styles.textStyle18,
              ),
              SizedBox(height: h * 0.005),
              Text(
                userEmail,
                style: Styles.textStyle14.copyWith(color: kGreyColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
