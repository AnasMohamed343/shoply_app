import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/view/auth/login_screen/login_screen.dart';
import 'package:shoply/view/widgets/custom_button.dart';
import 'package:shoply/view/widgets/custom_text_form_field.dart';
import 'package:shoply/view_model/auth_view_model.dart';

class RegisterScreen extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.off(LoginScreen());
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 18.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 30.h, left: 16.w, right: 15.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Sign Up',
                        style: Styles.textStyle30,
                      ),
                      SizedBox(height: 30.h),
                      CustomTextFormField(
                        fieldName: 'Name',
                        hintText: 'Enter your Name',
                        onSave: (value) {
                          controller.name = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                        },
                      ),
                      SizedBox(height: 30.h),
                      CustomTextFormField(
                        controller: controller.email,
                        fieldName: 'Email',
                        hintText: 'Enter your email',
                        onSave: (value) {
                          controller.email.text = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                        },
                      ),
                      SizedBox(height: 32.h),
                      CustomTextFormField(
                        controller: controller.password,
                        fieldName: 'Password',
                        hintText: 'Enter your password',
                        onSave: (value) {
                          controller.password.text = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                        },
                      ),
                      // SizedBox(height: 13.h),
                      // Text(
                      //   'Forgot Password?',
                      //   textAlign: TextAlign.end,
                      //   style: Styles.textStyle14,
                      // ),
                      SizedBox(height: 27.h),
                      GetBuilder<AuthViewModel>(builder: (controller) {
                        return CustomButton(
                          buttonText: controller.loading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.0,
                                )
                              : Text('SIGN UP', style: Styles.textStyle14),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save(); // Save form fields
                              controller.createAccountWithEmailAndPassword();
                            }
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
