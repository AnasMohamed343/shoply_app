import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/core/assets-manager.dart';
import 'package:shoply/core/common/widgets/custom_app_bar.dart';
import 'package:shoply/view/widgets/custom_button.dart';
import 'package:shoply/view/widgets/custom_container_imagepicker.dart';
import 'package:shoply/view/widgets/custom_imagepicker_button.dart';
import 'package:shoply/view/widgets/custom_text_form_field.dart';
import 'package:shoply/view_model/auth_view_model.dart';
import 'package:shoply/view_model/user_data_viewmodel.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final authController = Get.put(AuthViewModel());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Edit Profile'),
      body: GetBuilder<UserDataViewModel>(
          init: UserDataViewModel(),
          builder: (userController) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 40.h,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: userController.updateProfileFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
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
                                              buttonSize:
                                                  Size(w * 0.4, h * 0.05),
                                              buttonTextColor: Colors.white,
                                              onTap: () async {
                                                userController
                                                    .pickImage('camera');
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
                                                userController
                                                    .pickImage('gallery');
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
                          height: h * 0.2,
                          width: w * 0.3,
                          shape: BoxShape.circle,
                          backgroundImage: userController.pickedImage != null
                              ? MemoryImage(userController.pickedImage!)
                              : authController.userModel.picture == null ||
                                      authController.userModel.picture == ''
                                  ? null
                                  : Image.network(
                                          authController.userModel.picture)
                                      .image,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomTextFormField(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: kGreyColor.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        //controller: controller.nameController,
                        hintText: 'Name',
                        fieldName: 'Name',
                        controller: userController.nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextFormField(
                        suffixIcon: const Icon(Icons.lock),
                        readOnly: true,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: kGreyColor.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        //controller: controller.nameController,
                        hintText: 'Email',
                        fieldName: 'Email',
                        controller: userController.emailController,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomButton(
                        buttonText: Text('Save', style: Styles.textStyle14),
                        fixedSize: Size(double.infinity, h * 0.07),
                        onPressed: () {
                          userController.updateUser();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
