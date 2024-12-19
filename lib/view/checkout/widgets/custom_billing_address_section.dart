import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/core/common/widgets/custom_section_heading.dart';
import 'package:shoply/view_model/checkout_viewmodel.dart';

class CustomBillingAddressSection extends StatelessWidget {
  const CustomBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(CheckOutViewModel());
    final controller = CheckOutViewModel.instance;
    final double h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        CustomSectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () {},
        ),
        SizedBox(
          height: h * 0.01,
        ),
        Row(
          children: [
            Icon(
              Icons.phone,
              color: kGreyColor,
              size: 16.sp,
            ),
            SizedBox(
              width: h * 0.01,
            ),
            Text(
              '01095915172',
              style: Styles.textStyle16,
            ),
          ],
        ),
        SizedBox(
          height: h * 0.01,
        ),
        Row(
          children: [
            Icon(
              Icons.location_on,
              color: kGreyColor,
              size: 16.sp,
            ),
            SizedBox(
              width: h * 0.01,
            ),
            GetBuilder<CheckOutViewModel>(builder: (controller) {
              return Text(
                '${controller.street1! + ', ' + controller.street2! + ', ' + controller.city! + ', ' + controller.state! + ', ' + controller.country!}',
                style: Styles.textStyle16,
              );
            }),
          ],
        ),
      ],
    );
  }
}
