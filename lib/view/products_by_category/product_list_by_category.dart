import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/common/widgets/custom_app_bar.dart';
import 'package:shoply/model/product_model.dart';
import 'package:shoply/view/details_screen.dart';
import 'package:shoply/view/widgets/custom_product_item.dart';
import 'package:shoply/view_model/explore_screen_view_model.dart';

class ProductListByCategory extends StatelessWidget {
  String category;
  ProductListByCategory({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    ExploreScreenViewModel controller = Get.find<ExploreScreenViewModel>();
    controller.getProductsByCategory(category);
    return GetBuilder<ExploreScreenViewModel>(
        init: ExploreScreenViewModel(),
        builder: (controller) {
          List<ProductModel> products = controller.productListByCategory;
          controller.isLoading.value == true
              ? const Center(
                  child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ))
              : controller.isLoading.value == false;
          return Scaffold(
            appBar: CustomAppBar(
              title: category,
            ),
            body: GridView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => DetailsScreen(
                            model: products[index],
                          ));
                    },
                    child: CustomProductItem(
                      productModel: products[index],
                      flex: 2,
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.65,
                    crossAxisCount: 2)),
          );
        });
  }
}
