// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:shoply/core/Styles.dart';
// import 'package:shoply/view/widgets/category_list.dart';
// import 'package:shoply/view/widgets/custom_category_item.dart';
// import 'package:shoply/view/widgets/custom_product_item.dart';
// import 'package:shoply/view/widgets/custom_search_text_field.dart';
// import 'package:shoply/view_model/explore_screen_view_model.dart';
//
// class ExploreTabView extends StatelessWidget {
//   const ExploreTabView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     double h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.only(
//             top: 60.h,
//             left: 16.w,
//             right: 10.w,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const CustomSearchTextField(),
//               SizedBox(height: 25.h),
//               Text(
//                 textAlign: TextAlign.start,
//                 'Categories',
//                 style: Styles.textStyle18,
//               ),
//               SizedBox(height: 15.h),
//               SizedBox(
//                 height: h * 0.14,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: categoryList.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: EdgeInsets.only(right: 10.w),
//                       child: CustomCategoryItem(index: index),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Best Selling',
//                     style: Styles.textStyle18,
//                   ),
//                   Text(
//                     'See all',
//                     style: Styles.textStyle16,
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10.h),
//               SizedBox(
//                 height: h / 2.3,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 4,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: EdgeInsets.only(right: 20.w),
//                       child: const CustomProductItem(),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
////////// with getx and by loading  data from firebase not static //////////////

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/model/category_model.dart';
import 'package:shoply/view/details_screen.dart';
import 'package:shoply/view/products_by_category/product_list_by_category.dart';
import 'package:shoply/view/widgets/add_category_bottom_sheet.dart';
import 'package:shoply/view/widgets/add_product_bottom_sheet.dart';
import 'package:shoply/view/widgets/category_list.dart';
import 'package:shoply/view/widgets/custom_button.dart';
import 'package:shoply/view/widgets/custom_category_item.dart';
import 'package:shoply/view/widgets/custom_container_imagepicker.dart';
import 'package:shoply/view/widgets/custom_product_item.dart';
import 'package:shoply/view/widgets/custom_search_text_field.dart';
import 'package:shoply/view/widgets/custom_text_form_field.dart';
import 'package:shoply/view/widgets/show_custom_popup_menu.dart';
import 'package:shoply/view_model/explore_screen_view_model.dart';

class ExploreTabView extends GetView<ExploreScreenViewModel> {
  const ExploreTabView({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return GetBuilder<ExploreScreenViewModel>(
        init: ExploreScreenViewModel(),
        builder: (controller) {
          return controller.isLoading.value == true
              ? const Center(
                  child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ))
              : Scaffold(
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 60.h,
                        left: 16.w,
                        right: 10.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomSearchTextField(
                            //controller: controller.searchController,
                            onChanged: (value) {
                              controller.updateSearchQuery(
                                  value); // Update the filtered list based on the input
                            },
                            // onSubmitted: (value) {
                            //   controller.searchProducts(value);
                            // },
                          ),
                          SizedBox(height: 25.h),
                          Row(
                            children: [
                              Text(
                                textAlign: TextAlign.start,
                                'Categories',
                                style: Styles.textStyle18,
                              ),
                              const Spacer(),
                              CustomButton(
                                fixedSize: Size(w * 0.2, 25.h),
                                buttonText: 'ADD',
                                onPressed: () {
                                  controller.resetPickedImage();
                                  showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      isScrollControlled: true,
                                      useSafeArea: true,
                                      enableDrag: true,
                                      showDragHandle: true,
                                      isDismissible: true,
                                      context: context,
                                      builder: (context) =>
                                          AddCategoryBottomSheet(
                                            widgetTitle: 'Create New Category',
                                            buttonName: 'ADD',
                                          ));
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          SizedBox(
                            height: h * 0.14,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.categoryList.length,
                              itemBuilder: (context, index) {
                                final CategoryModel category =
                                    controller.categoryList[index];
                                // Create a unique key for each item
                                final GlobalKey itemKey = GlobalKey();
                                return Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => ProductListByCategory(
                                            category: controller
                                                    .categoryList[index].name ??
                                                '',
                                          ));
                                    },
                                    onLongPress: () {
                                      showCustomPopupMenu(
                                          context, itemKey, index, category);
                                    },
                                    child: CustomCategoryItem(
                                      key: itemKey, // Assign the key here
                                      categoryImage: controller
                                              .categoryList[index].image ??
                                          '',
                                      categoryName:
                                          controller.categoryList[index].name ??
                                              '',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Best Selling',
                                style: Styles.textStyle18,
                              ),
                              CustomButton(
                                buttonText: 'ADD',
                                fixedSize: Size(w * 0.2, 25.h),
                                onPressed: () {
                                  controller.resetPickedImage();
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      useSafeArea: true,
                                      enableDrag: true,
                                      showDragHandle: true,
                                      isDismissible: true,
                                      context: context,
                                      builder: (context) =>
                                          AddProductBottomSheet(
                                            widgetTitle: 'Create New Product',
                                            buttonName: 'Create',
                                          ));
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            height: h / 2.3,
                            child: controller.isLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                        color: kPrimaryColor),
                                  )
                                : controller.filteredProductList.isEmpty
                                    ? Center(
                                        child: Text(
                                          'No products found.',
                                          style: Styles.textStyle18,
                                        ),
                                      )
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: controller
                                            .filteredProductList.length,
                                        itemBuilder: (context, index) {
                                          final product = controller
                                              .filteredProductList[index];
                                          return Padding(
                                            padding:
                                                EdgeInsets.only(right: 20.w),
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.to(DetailsScreen(
                                                    model: product));
                                              },
                                              child: CustomProductItem(
                                                // productImage:
                                                //     controller.productList[index].image ??
                                                //         '',
                                                // productName:
                                                //     controller.productList[index].name ??
                                                //         '',
                                                // productPrice:
                                                //     controller.productList[index].price ??
                                                //         '',
                                                // description: controller
                                                //         .productList[index].description ??
                                                //     '',
                                                //productModel: controller.productList[index],
                                                productModel: product,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }
}
