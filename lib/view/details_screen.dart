import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/model/cart_product_model.dart';
import 'package:shoply/model/product_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoply/view/Explore_tab_view/explore_tab_view.dart';
import 'package:shoply/view/control_view.dart';
import 'package:shoply/view/widgets/add_product_bottom_sheet.dart';
import 'package:shoply/view/widgets/custom_button.dart';
import 'package:shoply/view_model/cart_viewmodel.dart';
import 'package:shoply/view_model/explore_screen_view_model.dart';

import 'widgets/custom_size&color_container.dart';

class DetailsScreen extends StatelessWidget {
  ProductModel model;
  DetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: h * 0.37,
                width: w,
                child: Image.network(
                  model.image ?? '',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 40.h,
                left: 10.w,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      //Row
                      children: [
                        Text(
                          model.name ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Styles.textStyle26,
                        ),
                        const Spacer(),
                        GetBuilder<ExploreScreenViewModel>(
                            init: ExploreScreenViewModel(),
                            builder: (controller) {
                              return Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: 'Delete',
                                        middleText:
                                            'Are you sure you want to delete this Product?',
                                        textConfirm: 'Yes',
                                        buttonColor: Colors.red,
                                        textCancel: 'No',
                                        confirmTextColor: Colors.white,
                                        onConfirm: () {
                                          controller.removeProduct(model).then(
                                                Get.back(),
                                                Get.back(),
                                                Get.snackbar(
                                                  'Deleted',
                                                  'Product Successfully Deleted',
                                                  snackPosition:
                                                      SnackPosition.TOP,
                                                  backgroundColor: Colors.red,
                                                  colorText: Colors.white,
                                                ),
                                              );
                                          //Get.to(ExploreTabView());
                                          //Get.to(ControlView());
                                        },
                                        titleStyle: Styles.textStyle18.copyWith(
                                          color: Colors.red,
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.delete,
                                        color: Colors.red, size: 20.sp),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      controller.resetPickedImage();
                                      showModalBottomSheet(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20.r),
                                              topRight: Radius.circular(20.r),
                                            ),
                                          ),
                                          isScrollControlled: true,
                                          useSafeArea: true,
                                          enableDrag: true,
                                          showDragHandle: true,
                                          isDismissible: true,
                                          context: context,
                                          builder: (context) =>
                                              AddProductBottomSheet(
                                                widgetTitle: 'Update Product',
                                                productModel: model,
                                                buttonName: 'Update',
                                              ));
                                    },
                                    icon: Icon(Icons.edit,
                                        color: Colors.blue, size: 20.sp),
                                  ),
                                ],
                              );
                            }),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomSizeColorContainer(
                          containerName: 'Size',
                          containerType: Text(
                            model.size ?? '',
                            style: Styles.textStyle14,
                          ),
                        ),
                        CustomSizeColorContainer(
                            containerName: 'Color',
                            containerType: Container(
                              height: h * 0.05,
                              width: h * 0.04,
                              decoration: BoxDecoration(
                                color: model.color,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: kGreyColor.withOpacity(0.5)),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Details',
                      style: Styles.textStyle18,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      model.description ?? '',
                      style: Styles.textStyle14.copyWith(
                        height: 2.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
              height: h * 0.093,
              width: w,
              padding:
                  const EdgeInsets.symmetric(horizontal: 23, vertical: 10).r,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'PRICE',
                        style: Styles.textStyle12.copyWith(color: kGreyColor),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        '\$ ${model.price}',
                        style:
                            Styles.textStyle18.copyWith(color: kPrimaryColor),
                      ),
                    ],
                  ),
                  GetBuilder<CartViewModel>(
                      init: CartViewModel(),
                      builder: (controller) {
                        return CustomButton(
                          buttonText: Text('ADD', style: Styles.textStyle14),
                          fixedSize: Size(146.w, 50.h),
                          onPressed: () {
                            if (controller
                                .isProductInCart(model.productId ?? '')) {
                              Get.snackbar(
                                'Already in cart',
                                'Product already in cart',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            } else {
                              controller.addProductToCart(
                                CartProductModel(
                                  name: model.name,
                                  image: model.image,
                                  price: model.price,
                                  quantity: 1,
                                  productId: model.productId,
                                ),
                              );
                              Get.snackbar(
                                'Added to cart',
                                'Product added to cart',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: kPrimaryColor,
                                colorText: Colors.white,
                              );
                            }
                          },
                        );
                      })
                ],
              )),
        ],
      ),
    );
  }
}
