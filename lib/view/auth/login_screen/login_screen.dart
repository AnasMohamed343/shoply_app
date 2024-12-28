import 'package:flutter/widgets.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/core/assets-manager.dart';
import 'package:shoply/view/auth/register_screen/register_screen.dart';
import 'package:shoply/view/widgets/custom_button.dart';
import 'package:shoply/view/widgets/custom_other_signIn_methods.dart';
import 'package:shoply/view/widgets/custom_text_form_field.dart';
import 'package:shoply/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Colors.white,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 100.h, left: 16.w, right: 15.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                  //margin: EdgeInsets.only(top: 70.h, left: 16.w, right: 15.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Welcome,',
                            style: Styles.textStyle30,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(RegisterScreen());
                            },
                            child: Text('Sign Up',
                                style: Styles.textStyle18
                                    .copyWith(color: kPrimaryColor)),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'Sign in to continue',
                        textAlign: TextAlign.start,
                        style: Styles.textStyle14.copyWith(color: kGreyColor),
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
                      SizedBox(height: 13.h),
                      Text(
                        'Forgot Password?',
                        textAlign: TextAlign.end,
                        style: Styles.textStyle14,
                      ),
                      SizedBox(height: 27.h),
                      GetBuilder<AuthViewModel>(builder: (controller) {
                        return CustomButton(
                            buttonText: controller.loading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.0,
                                  )
                                : Text('SIGN IN', style: Styles.textStyle14),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                controller.signInWithEmailAndPassword();
                              }
                            });
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),
                Text(
                  '-OR-',
                  textAlign: TextAlign.center,
                  style: Styles.textStyle18,
                ),
                SizedBox(height: 18.h),
                CustomOtherSignInMethods(
                  onPressed: () {},
                  buttonText: 'Sign in with Facebook',
                  assetIconName: AssetsManager.facebookIcon,
                ),
                SizedBox(height: 20.h),
                CustomOtherSignInMethods(
                  onPressed: () {
                    controller.googleSignInMethod();
                  },
                  buttonText: 'Sign in with Google',
                  assetIconName: AssetsManager.googleIcon,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
