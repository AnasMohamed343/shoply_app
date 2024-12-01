// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shoply/constants.dart';
// import 'package:shoply/core/Styles.dart';
// import 'package:shoply/view/widgets/category_list.dart';
//
// class CustomCategoryItem extends StatelessWidget {
//   final int index;
//   const CustomCategoryItem({super.key, required this.index});
//
//   @override
//   Widget build(BuildContext context) {
//     double h = MediaQuery.of(context).size.height;
//     return Column(
//       children: [
//         Container(
//           height: h * 0.09,
//           width: h * 0.09,
//           padding: EdgeInsets.all(13.h),
//           decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: kLightGrey.withOpacity(0.8),
//                   spreadRadius: 3,
//                   blurRadius: 7,
//                   offset: const Offset(2, 2), // changes position of shadow
//                 ),
//               ]),
//           child: categoryList[index].image,
//         ),
//         SizedBox(height: 15.h),
//         Text(
//           categoryList[index].name ?? '',
//           style: Styles.textStyle12,
//         ),
//       ],
//     );
//   }
// }
////////  with getx and by loading  data from firebase not static //////////////
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/view/widgets/category_list.dart';

class CustomCategoryItem extends StatelessWidget {
  String categoryImage, categoryName;
  CustomCategoryItem({
    Key? key, // Accept the key parameter
    required this.categoryImage,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
            height: h * 0.09,
            width: h * 0.09,
            padding: EdgeInsets.all(12.h),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: kLightGrey.withOpacity(0.8),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(2, 2), // changes position of shadow
                  ),
                ]),
            child: Image.network(
              categoryImage,
              fit: BoxFit.contain,
            ) //SvgPicture.network(categoryImage), //Image.network(categoryImage), use Svg instead of normal image , because images saved in database as svg images.
            ),
        SizedBox(height: 15.h),
        Text(
          categoryName,
          style: Styles.textStyle12,
        ),
      ],
    );
  }
}
