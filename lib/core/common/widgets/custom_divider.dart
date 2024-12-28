import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoply/constants.dart';

class CustomDivider extends StatelessWidget {
  final double? verticalPadding;
  const CustomDivider({
    super.key,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 15).r,
      child: Divider(
        color: Colors.grey.shade200,
        thickness: 1.5,
        indent: 5,
        endIndent: 5,
      ),
    );
  }
}
