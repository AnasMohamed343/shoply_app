import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/core/common/widgets/custom_app_bar.dart';
import 'package:shoply/view/widgets/custom_button.dart';
import 'package:shoply/view/widgets/custom_text_form_field.dart';
import 'package:shoply/view_model/user_data_viewmodel.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserDataViewModel.instance;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Change Password'),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: controller.changePasswordFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextFormField(
                controller: controller.currentPasswordController,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: kGreyColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(10),
                ),
                fieldName: 'Current Password',
                hintText: 'enter current password',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter current password';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextFormField(
                controller: controller.newPasswordController,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: kGreyColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(10),
                ),
                fieldName: 'New Password',
                hintText: 'enter new password',
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                buttonText: Text('Save', style: Styles.textStyle14),
                fixedSize: Size(double.infinity, 50.h),
                onPressed: () {
                  controller.updateUserPassword();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
