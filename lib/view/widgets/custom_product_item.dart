import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/model/cart_product_model.dart';
import 'package:shoply/model/product_model.dart';
import 'package:shoply/view_model/explore_screen_view_model.dart';

import 'custom_button.dart';

class CustomProductItem extends StatelessWidget {
  //String productImage, productName, productPrice, description;
  ProductModel? productModel;
  int? flex = 3;
  CustomProductItem({
    super.key,
    this.productModel,
    this.flex,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: flex ?? 3,
          child: Container(
            height: h * 0.2,
            width: h * 0.2,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.network(productModel?.image ?? '').image,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        SizedBox(height: 7.h),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: h * 0.19,
                child: Text(productModel?.name ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Styles.textStyle16),
              ),
              SizedBox(height: 7.h),
              SizedBox(
                width: h * 0.15,
                child: Text(productModel?.description ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Styles.textStyle12.copyWith(color: kGreyColor)),
              ),
              SizedBox(height: 7.h),
              Text(
                '\$ ${productModel?.price}',
                style: Styles.textStyle16.copyWith(color: kPrimaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
