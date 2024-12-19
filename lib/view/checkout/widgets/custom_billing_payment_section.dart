import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/core/assets-manager.dart';
import 'package:shoply/core/common/widgets/custom_section_heading.dart';
import 'package:shoply/view_model/checkout_viewmodel.dart';

class CustomBillingPaymentSection extends StatelessWidget {
  const CustomBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckOutViewModel());
    final double h = MediaQuery.of(context).size.height;
    return Column(children: [
      CustomSectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () {
            controller.selectPaymentMethod(context);
          }),
      SizedBox(
        height: h * 0.01,
      ),
      Obx(
        () => Row(
          children: [
            Container(
              height: h * 0.06,
              width: h * 0.06,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: kLightGrey,
                ),
              ),
              child: Image(
                  image: AssetImage(
                      controller.selectedPaymentMethod.value.image ?? '')),
            ),
            SizedBox(
              width: h * 0.02,
            ),
            Text(
              controller.selectedPaymentMethod.value.name ?? '',
              style: Styles.textStyle18.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
