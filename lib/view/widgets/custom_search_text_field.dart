import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/assets-manager.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: kLightGrey,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 25.w,
          vertical: 10.h,
        ),
        prefixIconConstraints: BoxConstraints(
          minHeight: 25.h,
          minWidth: 25.w,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.r), // Rounded corners
          borderSide: const BorderSide(
              color: Colors.transparent), // Removes the visible border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(25.r), // Rounded corners when focused
          borderSide: const BorderSide(
              color: Colors.transparent), // Highlight border on focus
        ),
        border: InputBorder.none,
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          child: SvgPicture.asset(
            AssetsManager.searchIcon,
            height: 22.h,
            width: 22.w,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
