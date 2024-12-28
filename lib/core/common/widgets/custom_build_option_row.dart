import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';

Widget buildOptionRow(BuildContext context,
    {IconData? icon,
    String? asset,
    required String title,
    required VoidCallback onTap}) {
  final w = MediaQuery.of(context).size.width;
  final h = MediaQuery.of(context).size.height;

  return GestureDetector(
    onTap: onTap,
    child: Row(
      children: [
        if (icon != null)
          Icon(icon,
              color: kPrimaryColor,
              size: w * 0.05) // Replace with kPrimaryColor
        else if (asset != null)
          SvgPicture.asset(
            asset,
            color: kPrimaryColor, // Replace with kPrimaryColor
            height: h * 0.03,
            width: w * 0.03,
          ),
        SizedBox(width: w * 0.03),
        Text(title, style: Styles.textStyle16),
        const Spacer(),
        Icon(Icons.arrow_forward_ios,
            color: kPrimaryColor, size: w * 0.05), // Replace with kPrimaryColor
      ],
    ),
  );
}

// Widget buildDivider() {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 15).r,
//     child: Divider(
//       color: Colors.grey.shade200,
//       thickness: 1.5,
//       indent: 5,
//       endIndent: 5,
//     ),
//   );
// }
