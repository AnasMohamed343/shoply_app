import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';

class CustomImagePickerButton extends StatelessWidget {
  String buttonText;
  Color? buttonColor;
  Color? buttonTextColor;
  Function() onTap;
  IconData? icon;
  Size? buttonSize;
  Widget? iconWidget;
  CustomImagePickerButton({
    required this.buttonText,
    this.buttonColor,
    this.buttonTextColor,
    required this.onTap,
    this.icon,
    this.buttonSize,
    this.iconWidget,
  });
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: w * 0.02, end: w * 0.01, start: w * 0.01, bottom: w * 0.02),
      child: Column(
        children: [
          Icon(
            icon,
            color: kPrimaryColor,
            size: 30.sp,
          ),
          SizedBox(height: h * 0.01),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: buttonSize ?? Size(w * 0.9, h * 0.06),
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                onTap();
              },
              child: Text(
                buttonText,
                style: Styles.textStyle18.copyWith(
                  color: buttonTextColor,
                ),
              )),
        ],
      ),
    );
  }
}
