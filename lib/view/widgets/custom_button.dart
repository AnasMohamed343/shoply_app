import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Widget buttonText;
  final void Function()? onPressed;
  Size? fixedSize = Size(311.w, 50.h);
  Color? foregroundColor, backgroundColor, borderColor = kPrimaryColor;
  double? borderRadius;
  CustomButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.fixedSize,
      this.foregroundColor,
      this.backgroundColor,
      this.borderColor,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? kPrimaryColor,
        fixedSize: fixedSize,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 5.r),
        ),
        foregroundColor: foregroundColor ?? Colors.white,
        side: BorderSide(color: borderColor ?? kPrimaryColor, width: 1.w),
      ),
      child: buttonText, //Text(buttonText, style: Styles.textStyle14),
    );
  }
}
