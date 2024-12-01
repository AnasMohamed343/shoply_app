import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;
  Size? fixedSize = Size(311.w, 50.h);
  CustomButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.fixedSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        fixedSize: fixedSize,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
        foregroundColor: Colors.white,
      ),
      child: Text(buttonText, style: Styles.textStyle14),
    );
  }
}
