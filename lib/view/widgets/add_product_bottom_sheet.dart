import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/core/service/supabase_upload_image.dart';
import 'package:shoply/model/product_model.dart';
import 'package:shoply/utils/image_functions.dart';
import 'package:shoply/view/Explore_tab_view/explore_tab_view.dart';
import 'package:shoply/view/control_view.dart';
import 'package:shoply/view/widgets/custom_button.dart';
import 'package:shoply/view/widgets/custom_color_picker_widget.dart';
import 'package:shoply/view/widgets/custom_container_imagepicker.dart';
import 'package:shoply/view/widgets/custom_dropdown_button.dart';
import 'package:shoply/view/widgets/custom_imagepicker_button.dart';
import 'package:shoply/view/widgets/custom_text_form_field.dart';
import 'package:shoply/view_model/explore_screen_view_model.dart';

class AddProductBottomSheet extends StatelessWidget {
  String widgetTitle, buttonName;
  ProductModel? productModel;
  //dynamic Function() onButtonPressed;
  AddProductBottomSheet(
      {super.key,
      required this.widgetTitle,
      this.productModel,
      required this.buttonName});

  // TextEditingController productNameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Uint8List? pickedImage;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: GetBuilder<ExploreScreenViewModel>(
          init: ExploreScreenViewModel(),
          builder: (controller) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              height: h * 1.2,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      widgetTitle,
                      style: Styles.textStyle18,
                    ),
                    SizedBox(height: 30.h),
                    Text('Add Product Image',
                        textAlign: TextAlign.start, style: Styles.textStyle16),
                    SizedBox(height: 15.h),
                    GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                double h = MediaQuery.of(context).size.height;
                                return Container(
                                  height: h * 0.2,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Text(
                                        'Pick Product Image',
                                        style: Styles.textStyle20,
                                      ),
                                      SizedBox(
                                        height: h * 0.02,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomImagePickerButton(
                                              icon: Icons.camera_alt_outlined,
                                              buttonText: 'Camera',
                                              buttonColor: kPrimaryColor,
                                              buttonSize:
                                                  Size(w * 0.4, h * 0.05),
                                              buttonTextColor: Colors.white,
                                              onTap: () async {
                                                controller.pickImage('camera');
                                                Get.back();
                                              }),
                                          CustomImagePickerButton(
                                              icon: Icons.image_outlined,
                                              buttonText: 'Gallery',
                                              buttonColor: kPrimaryColor,
                                              buttonSize:
                                                  Size(w * 0.4, h * 0.05),
                                              buttonTextColor: Colors.white,
                                              onTap: () async {
                                                controller.pickImage('gallery');
                                                Get.back();
                                              }),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: CustomContainerImagePicker(
                          borderRadius: BorderRadius.circular(10.r),
                          backgroundImage: controller.pickedImage != null
                              ? MemoryImage(controller.pickedImage!)
                              : productModel?.image != null
                                  ? Image.network(productModel!.image!).image
                                  : null,
                        )),
                    SizedBox(height: 25.h),
                    CustomTextFormField(
                      fieldName: 'Add Product Name',
                      fieldNameColor: Colors.black,
                      hintText: productModel?.name ?? 'product name',
                      hintTextColor: kGreyColor,
                      onSave: (value) {
                        //controller.name = value;
                        controller.name = value?.isNotEmpty == true
                            ? value
                            : productModel?.name;
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomTextFormField(
                      fieldName: 'Add Product Details',
                      fieldNameColor: Colors.black,
                      hintText: productModel?.description ?? 'product details',
                      hintTextColor: kGreyColor,
                      onSave: (value) {
                        //controller.description = value ?? '';
                        controller.description = value?.isNotEmpty == true
                            ? value
                            : productModel?.description;
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomTextFormField(
                      fieldName: 'Add Product Price',
                      fieldNameColor: Colors.black,
                      hintText: productModel?.price ?? 'product price',
                      hintTextColor: kGreyColor,
                      onSave: (value) {
                        //controller.price = value ?? '';
                        controller.price = value?.isNotEmpty == true
                            ? value
                            : productModel?.price;
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomTextFormField(
                      fieldName: 'Add Product Size',
                      fieldNameColor: Colors.black,
                      hintText: productModel?.size ?? 'product size',
                      hintTextColor: kGreyColor,
                      onSave: (value) {
                        //controller.size = value ?? '';
                        controller.size = value?.isNotEmpty == true
                            ? value
                            : productModel?.size;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // CustomTextFormField(
                    //   fieldName: 'Add Product Category',
                    //   fieldNameColor: Colors.black,
                    //   hintText:
                    //       productModel?.productCategory ?? 'product category',
                    //   hintTextColor: kGreyColor,
                    //   onSave: (value) {
                    //     //controller.productCategory = value ?? '';
                    //     controller.productCategory = value?.isNotEmpty == true
                    //         ? value
                    //         : productModel?.productCategory;
                    //   },
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomDropdownButton(
                          currentCategory: controller.productCategory ??
                              productModel?.productCategory,
                          fieldName: 'Product Category',
                          onSaved: (value) {
                            controller.productCategory =
                                value?.isNotEmpty == true
                                    ? value
                                    : productModel?.productCategory;
                          },
                        ),
                        CustomColorPickerWidget(
                          currentColor: controller.pickerColor == null ||
                                  controller.pickerColor == Colors.white
                              ? productModel?.color
                              : controller.pickerColor,
                          onSaved: (value) {
                            controller.color = value?.isNotEmpty == true
                                ? value
                                : productModel?.color;
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    controller.isLoading.value == true
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ))
                        : CustomButton(
                            buttonText: Text(buttonName),
                            fixedSize: Size(w, h / 15),
                            onPressed: () async {
                              if (controller.pickedImage != null ||
                                  productModel?.image != null) {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!
                                      .save(); // Save form data

                                  String? uploadedImageUrl;
                                  // Upload image to storage
                                  if (controller.pickedImage != null) {
                                    //productModel?.image == null
                                    uploadedImageUrl =
                                        await SupabaseUploadImage()
                                            .uploadImageToStorage(
                                                image: controller.pickedImage!,
                                                filePathName: 'products');
                                  }

                                  // Create a ProductModel instance
                                  // ProductModel newProduct = ProductModel(
                                  //   name: productModel?.name == null ||
                                  //           productModel?.name == ''
                                  //       ? controller.name
                                  //       : productModel?.name,
                                  //   description:
                                  //       productModel?.description == null ||
                                  //               productModel?.description == ''
                                  //           ? controller.description
                                  //           : productModel?.description,
                                  //   price: productModel?.price == null ||
                                  //           productModel?.price == ''
                                  //       ? controller.price
                                  //       : productModel?.price,
                                  //   size: productModel?.size == null ||
                                  //           productModel?.size == ''
                                  //       ? controller.size
                                  //       : productModel?.size,
                                  //   // image: productModel?.image == null ||
                                  //   //         productModel?.image == ''
                                  //   //     ? uploadedImageUrl
                                  //   //     : productModel?.image,
                                  //   image: uploadedImageUrl == null ||
                                  //           uploadedImageUrl == ''
                                  //       ? productModel?.image
                                  //       : uploadedImageUrl,
                                  //   productCategory:
                                  //       productModel?.productCategory == null ||
                                  //               productModel?.productCategory ==
                                  //                   ''
                                  //           ? controller.productCategory
                                  //           : productModel?.productCategory,
                                  //   productId:
                                  //       productModel?.productId == null ||
                                  //               productModel?.productId == ''
                                  //           ? UniqueKey().toString()
                                  //           : productModel?.productId,
                                  // );

                                  ProductModel newProduct = ProductModel(
                                    name: controller.name,
                                    description: controller.description,
                                    price: controller.price,
                                    size: controller.size,
                                    image: uploadedImageUrl ??
                                        productModel?.image ??
                                        '',
                                    productCategory: controller.productCategory,
                                    color: controller.color,
                                    productId: productModel?.productId ??
                                        UniqueKey().toString(),
                                  );

                                  if (productModel == null) {
                                    controller.addNewProduct(newProduct);
                                  } else {
                                    controller.updateProduct(newProduct);
                                  }
                                  Get.back();
                                  Get.back();
                                  // productModel == null
                                  //     ? controller.addNewProduct(newProduct)
                                  //     : controller
                                  //         .updateProduct(newProduct)
                                  //         .then((value) => Get.back());
                                }
                              } else {
                                Get.snackbar(
                                    'Error', 'Please add a product image');
                              }
                            }),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
