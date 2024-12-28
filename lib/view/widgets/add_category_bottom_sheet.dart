import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/core/service/supabase_upload_image.dart';
import 'package:shoply/model/category_model.dart';
import 'package:shoply/utils/image_functions.dart';
import 'package:shoply/view/widgets/custom_button.dart';
import 'package:shoply/view/widgets/custom_container_imagepicker.dart';
import 'package:shoply/view/widgets/custom_imagepicker_button.dart';
import 'package:shoply/view/widgets/custom_text_form_field.dart';
import 'package:shoply/view_model/explore_screen_view_model.dart';

class AddCategoryBottomSheet extends StatelessWidget {
  String widgetTitle, buttonName;
  CategoryModel? categoryModel;
  AddCategoryBottomSheet(
      {super.key,
      required this.widgetTitle,
      this.categoryModel,
      required this.buttonName});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Uint8List? pickedImage;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      height: h / 1.6,
      child: GetBuilder<ExploreScreenViewModel>(
          init: ExploreScreenViewModel(),
          builder: (controller) {
            return Form(
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
                  Text('Add Category Image',
                      textAlign: TextAlign.start, style: Styles.textStyle16),
                  SizedBox(height: 15.h),
                  GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
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
                                      'Pick Category Image',
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
                                            buttonSize: Size(w * 0.4, h * 0.05),
                                            buttonTextColor: Colors.white,
                                            onTap: () async {
                                              controller.pickImage('camera');
                                              Get.back();
                                            }),
                                        CustomImagePickerButton(
                                            icon: Icons.image_outlined,
                                            buttonText: 'Gallery',
                                            buttonColor: kPrimaryColor,
                                            buttonSize: Size(w * 0.4, h * 0.05),
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
                        height: h * 0.16,
                        width: h * 0.17,
                        shape: BoxShape.circle,
                        backgroundImage: controller.pickedImage != null
                            ? MemoryImage(controller.pickedImage!)
                            : categoryModel?.image != null
                                ? Image.network(categoryModel!.image!).image
                                : null,
                      )),
                  SizedBox(height: 25.h),
                  CustomTextFormField(
                    fieldName: 'Add Category Name',
                    fieldNameColor: Colors.black,
                    hintText: categoryModel?.name ?? 'category name',
                    hintTextColor: kGreyColor,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter category name';
                      }
                      return null;
                    },
                    onSave: (value) {
                      controller.categoryName = value?.isNotEmpty == true
                          ? value
                          : categoryModel?.name;
                    },
                  ),
                  SizedBox(height: 40.h),
                  controller.isLoading.value == true
                      ? const CircularProgressIndicator(
                          color: kPrimaryColor,
                        )
                      : CustomButton(
                          buttonText: Text(buttonName),
                          fixedSize: Size(w, h / 15),
                          onPressed: () async {
                            if (controller.pickedImage != null ||
                                categoryModel?.image != null) {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();

                                String? uploadedImageUrl;
                                if (controller.pickedImage != null) {
                                  uploadedImageUrl = await SupabaseUploadImage()
                                      .uploadImageToStorage(
                                          image: controller.pickedImage!,
                                          filePathName: 'categories');
                                }

                                CategoryModel newCategory = CategoryModel(
                                  name: controller.categoryName,
                                  image: uploadedImageUrl ??
                                      categoryModel?.image ??
                                      '',
                                  categoryId: categoryModel?.categoryId ??
                                      UniqueKey().toString(),
                                );

                                if (categoryModel == null) {
                                  controller.addCategory(
                                      newCategory); // Add if no categoryModel
                                } else {
                                  controller.updateCategory(
                                      newCategory); // Update if categoryModel exists
                                }
                                Get.back();
                              }
                            } else {
                              Get.snackbar('Error', 'Please select image');
                            }
                          },
                        )
                ],
              ),
            );
          }),
    );
  }
}
