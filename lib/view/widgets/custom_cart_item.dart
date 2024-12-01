import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';

class CustomCartItem extends StatelessWidget {
  String name, picture;
  String price;
  int quantity;
  void Function()? onPressedIncreaseQuantity, onPressedDecreaseQuantity;
  void Function(BuildContext)? onPressedDeleteProduct;
  CustomCartItem(
      {super.key,
      required this.name,
      required this.picture,
      required this.price,
      required this.quantity,
      required this.onPressedIncreaseQuantity,
      required this.onPressedDecreaseQuantity,
      required this.onPressedDeleteProduct});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: .2.sp, //the size or the width
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),
        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: onPressedDeleteProduct,
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
          extentRatio: .2.sp, //the size or the width
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: const Color(0xFFFFC107),
              foregroundColor: Colors.white,
              icon: Icons.star_rounded,
              label: 'Favorite',
            ),
          ]),
      child: Container(
        height: h * 0.18,
        width: w,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17).r,
        child: Row(
          children: [
            Container(
              height: h * 0.18,
              width: h * 0.16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                image: DecorationImage(
                  image: Image.network(picture).image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(width: 25.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: Styles.textStyle16,
                ),
                SizedBox(height: 7.h),
                Text(
                  '\$ $price',
                  style: Styles.textStyle16.copyWith(color: kPrimaryColor),
                ),
                SizedBox(height: 10.h),
                Container(
                  height: h * 0.05,
                  width: w * 0.3,
                  decoration: BoxDecoration(
                    color: kGreyColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: onPressedDecreaseQuantity,
                        icon: Icon(Icons.remove,
                            color: Colors.black, size: 20.sp),
                      ),
                      Text(
                        '$quantity',
                        style: Styles.textStyle16,
                      ),
                      IconButton(
                        onPressed: onPressedIncreaseQuantity,
                        icon: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
