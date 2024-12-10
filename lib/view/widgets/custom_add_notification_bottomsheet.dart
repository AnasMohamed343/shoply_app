import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/core/service/supabase_upload_image.dart';
import 'package:shoply/model/notification_model.dart';
import 'package:shoply/view/widgets/custom_button.dart';
import 'package:shoply/view/widgets/custom_container_imagepicker.dart';
import 'package:shoply/view/widgets/custom_imagepicker_button.dart';
import 'package:shoply/view/widgets/custom_text_form_field.dart';
import 'package:shoply/view_model/notification_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAddNotificationBottomSheet extends StatelessWidget {
  CustomAddNotificationBottomSheet({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    const String addNotification = 'Add Notification';
    return Form(
      key: formKey,
      child: GetBuilder<NotificationViewModel>(
          init: NotificationViewModel(),
          builder: (controller) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              height: h / 1.36,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    addNotification,
                    style: Styles.textStyle18,
                  ),
                  SizedBox(height: 30.h),
                  Text('$addNotification Image',
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
                                      'Pick Notification Image',
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
                        height: h * 0.18,
                        width: h * 0.17,
                        shape: BoxShape.rectangle,
                        backgroundImage: controller.pickedImage != null
                            ? MemoryImage(controller.pickedImage!)
                            : null,
                      )),
                  SizedBox(height: 25.h),
                  CustomTextFormField(
                    fieldName: '$addNotification Title',
                    fieldNameColor: Colors.black,
                    hintText: 'title',
                    hintTextColor: kGreyColor,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter notification title';
                      }
                      return null;
                    },
                    onSave: (value) {
                      controller.title = value;
                    },
                  ),
                  SizedBox(height: 25.h),
                  CustomTextFormField(
                    fieldName: '$addNotification Body',
                    fieldNameColor: Colors.black,
                    hintText: 'body',
                    hintTextColor: kGreyColor,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter notification body';
                      }
                      return null;
                    },
                    onSave: (value) {
                      controller.body = value;
                    },
                  ),
                  SizedBox(height: 40.h),
                  controller.isLoading.value == true
                      ? const CircularProgressIndicator(
                          color: kPrimaryColor,
                        )
                      : CustomButton(
                          buttonText: addNotification,
                          fixedSize: Size(w, h / 15),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();

                              String? uploadedImageUrl;
                              if (controller.pickedImage != null) {
                                uploadedImageUrl = await SupabaseUploadImage()
                                    .uploadImageToStorage(
                                        image: controller.pickedImage!,
                                        filePathName: 'notifications');
                              }

                              controller.sendNotification(
                                NotificationModel(
                                    title: controller.title ?? '',
                                    body: controller.body ?? '',
                                    image: controller.pickedImage != null
                                        ? uploadedImageUrl
                                        : null,
                                    topic: 'all'),
                              );
                              Get.back();
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
