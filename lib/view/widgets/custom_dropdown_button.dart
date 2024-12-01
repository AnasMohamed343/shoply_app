import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/view_model/explore_screen_view_model.dart';

class CustomDropdownButton extends StatelessWidget {
  final String fieldName;
  final String? currentCategory;
  final void Function(String?)? onSaved;
  CustomDropdownButton(
      {super.key, required this.fieldName, this.onSaved, this.currentCategory});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(fieldName, style: Styles.textStyle16),
        SizedBox(height: 15.h),
        GetBuilder<ExploreScreenViewModel>(
            init: ExploreScreenViewModel(),
            builder: (controller) {
              return SizedBox(
                height: h * 0.07,
                width: w * 0.38,
                child: DropdownButtonFormField<String>(
                  iconDisabledColor: kPrimaryColor,
                  iconEnabledColor: kPrimaryColor,
                  value: currentCategory, //controller.selectedCategoryName,
                  items: controller.categoryList.map((category) {
                    return DropdownMenuItem<String>(
                      value: category.name,
                      child:
                          Text(category.name ?? '', style: Styles.textStyle14),
                    );
                  }).toList(),
                  onSaved: onSaved,
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectedCategoryName = value;
                      controller.getProductsByCategory(value);
                    }
                  },
                  focusColor: kPrimaryColor,
                  menuMaxHeight: h / 3.5,
                  isExpanded: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.r),
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.r),
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.r),
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    focusColor: kPrimaryColor,
                  ),
                ),
              );
            }),
      ],
    );
  }
}
