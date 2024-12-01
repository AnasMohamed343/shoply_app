import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/view/checkout/checkout_view.dart';
import 'package:shoply/view/widgets/custom_button.dart';
import 'package:shoply/view/widgets/custom_cart_item.dart';
import 'package:shoply/view_model/cart_viewmodel.dart';

class CartTabView extends StatelessWidget {
  // List<String> name = <String>[
  //   'item1',
  //   'item2',
  //   'item3',
  // ];
  // List<String> picture = <String>[
  //   'assets/images/B&o Desk Lamp.png',
  //   'assets/images/BeoPlay Stand Speaker.png',
  //   'assets/images/BeoPlay_Speaker.png',
  // ];
  // List<int> price = <int>[
  //   100,
  //   200,
  //   300,
  // ];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GetBuilder<CartViewModel>(
        init: CartViewModel(),
        builder: (controller) {
          return controller.loading.value == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                )
              : controller.cartProductList?.isEmpty == true
                  ? const Scaffold(
                      backgroundColor: Colors.white,
                      body: Center(
                          child: Text(
                        "Cart is empty",
                      )),
                    )
                  : Scaffold(
                      backgroundColor: Colors.white,
                      body: Column(
                        children: [
                          Expanded(
                            child: Container(
                              child: ListView.builder(
                                itemCount: controller.cartProductList?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return CustomCartItem(
                                    name: controller
                                            .cartProductList?[index].name ??
                                        '',
                                    picture: controller
                                            .cartProductList?[index].image ??
                                        '',
                                    price: controller
                                            .cartProductList?[index].price ??
                                        '',
                                    quantity: controller
                                            .cartProductList?[index].quantity ??
                                        0,
                                    onPressedIncreaseQuantity: () {
                                      controller.increaseQuantity(index);
                                    },
                                    onPressedDecreaseQuantity: () {
                                      controller.decreaseQuantity(index);
                                    },
                                    onPressedDeleteProduct: (context) {
                                      controller.deleteProduct(index);
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                              height: h * 0.093,
                              width: w,
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 23, vertical: 10)
                                  .r,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'TOTAL',
                                        style: Styles.textStyle12
                                            .copyWith(color: kGreyColor),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Text(
                                        '\$ ${controller.getTotalPrice()}',
                                        style: Styles.textStyle18
                                            .copyWith(color: kPrimaryColor),
                                      ),
                                      // Obx(() {
                                      //   return Text(
                                      //     '\$ ${controller.getTotalPrice()}',
                                      //     style: Styles.textStyle18
                                      //         .copyWith(color: kPrimaryColor),
                                      //   );
                                      // }),
                                    ],
                                  ),
                                  CustomButton(
                                    buttonText: 'CHECKOUT',
                                    fixedSize: Size(146.w, 50.h),
                                    onPressed: () {
                                      Get.to(const CheckoutView());
                                    },
                                  )
                                ],
                              )),
                        ],
                      ),
                    );
        });
  }
}
