import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/core/assets-manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomOtherSignInMethods extends StatelessWidget {
  final String buttonText, assetIconName;
  final void Function()? onPressed;
  const CustomOtherSignInMethods(
      {super.key,
      required this.buttonText,
      required this.assetIconName,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: kLightGrey, width: 1.w),
        fixedSize: Size(343.w, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
        foregroundColor: Colors.black,
        elevation: 0.0,
        padding: EdgeInsets.only(left: 16.w, right: 15.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(assetIconName, width: 20.w, height: 20.h),
          //SizedBox(width: 57.w),
          Text(
            buttonText,
            style: Styles.textStyle14,
          ),
        ],
      ),
    );
  }
}

//
// Container(
// width: 343.w,
// height: 50.h,
// padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
// margin: EdgeInsets.only(left: 16.w, right: 15.w),
// decoration: BoxDecoration(
// color: Colors.white,
// border: Border.all(color: kLightGrey, width: 1.w),
// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.1),
// spreadRadius: 5,
// blurRadius: 7,
// offset: const Offset(0, 3), // changes position of shadow
// ),
// ],
// ),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// SvgPicture.asset(assetIconName, width: 20.w, height: 20.h),
// //SizedBox(width: 57.w),
// Text(
// buttonText,
// style: Styles.textStyle14,
// ),
// ],
// ),
// )
