import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/core/common/widgets/custom_divider.dart';
import 'package:shoply/core/common/widgets/custom_section_heading.dart';
import 'package:shoply/view/checkout/widgets/custom_billing_address_section.dart';
import 'package:shoply/view/checkout/widgets/custom_billing_payment_section.dart';
import 'package:shoply/view/widgets/custom_product_item.dart';
import 'package:shoply/view_model/cart_viewmodel.dart';
import 'package:shoply/view_model/checkout_viewmodel.dart';

class Summary extends StatelessWidget {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return GetBuilder<CartViewModel>(
        //init: Get.put(CartViewModel()),
        builder: (controller) {
      return Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: h * 0.3,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.cartProductList?.length ?? 0,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: w * 0.03,
                    );
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      height: h * 0.3,
                      width: w * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: h * 0.2,
                            width: w * 0.5,
                            child: Image.network(
                              controller.cartProductList?[index].image ?? '',
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: h * 0.01,
                          ),
                          // SizedBox(
                          //   width: w * 0.5,
                          //   child: Text(
                          //       controller.cartProductList?[index].name ?? '',
                          //       maxLines: 1,
                          //       overflow: TextOverflow.ellipsis,
                          //       style: Styles.textStyle16),
                          // ),
                          RichText(
                              maxLines: 1,
                              //overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                style: Styles.textStyle16
                                    .copyWith(color: Colors.black),
                                text: controller.cartProductList?[index].name ??
                                    '',
                              )),
                          SizedBox(
                            height: h * 0.01,
                          ),
                          Text(
                            '${controller.cartProductList?[index].price} \$',
                            style: Styles.textStyle16.copyWith(
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.h),
                margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: kGreyColor.withOpacity(0.5), width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Order Total',
                          style: Styles.textStyle18,
                        ),
                        const Spacer(),
                        Text(
                          '${controller.getTotalPrice} \$',
                          style: Styles.textStyle18.copyWith(
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    const CustomDivider(
                      verticalPadding: 8,
                    ),
                    CustomBillingPaymentSection(),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    CustomBillingAddressSection(),
                  ],
                ),
              ),
              SizedBox(
                height: h * 0.02,
              ),
            ],
          ),
        ),
      );
    });
  }
}
