import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/view/widgets/custom_product_item.dart';
import 'package:shoply/view_model/cart_viewmodel.dart';
import 'package:shoply/view_model/checkout_viewmodel.dart';

class Summary extends StatelessWidget {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Expanded(
      child: GetBuilder<CartViewModel>(builder: (controller) {
        return Column(
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
                    width: w * 0.02,
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
                              text:
                                  controller.cartProductList?[index].name ?? '',
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
            Text(
              'Shipping Address',
              style: Styles.textStyle20,
            ),
            SizedBox(
              height: h * 0.01,
            ),
            GetBuilder<CheckOutViewModel>(builder: (controller) {
              return Text(
                '${controller.street1! + ', ' + controller.street2! + ', ' + controller.city! + ', ' + controller.state! + ', ' + controller.country!}',
                style: Styles.textStyle18.copyWith(color: kGreyColor),
              );
            }),
            SizedBox(
              height: h * 0.01,
            ),
            Text(
              'Payment Method',
              style: Styles.textStyle20,
            ),
            SizedBox(
              height: h * 0.01,
            ),
            Text(
              'Cash on delivery',
              style: Styles.textStyle16.copyWith(color: kGreyColor),
            ),
          ],
        );
      }),
    );
  }
}
