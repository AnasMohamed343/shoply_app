// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shoply/view/auth/login_screen/login_screen.dart';
// import 'package:shoply/view/home_Screen.dart';
// import 'package:shoply/view_model/auth_view_model.dart';
//
// class ControlView extends GetWidget<AuthViewModel> {
//   const ControlView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return (Get.find<AuthViewModel>().user != '')
//           ? HomeScreen()
//           : LoginScreen();
//     });
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/core/assets-manager.dart';
import 'package:shoply/view/auth/login_screen/login_screen.dart';
import 'package:shoply/view/home_Screen.dart';
import 'package:shoply/view_model/auth_view_model.dart';
import 'package:shoply/view_model/control_view_model.dart';

class ControlView extends GetWidget<AuthViewModel> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthViewModel>().user == '')
          ? LoginScreen()
          : GetBuilder<ControlViewModel>(builder: (controller) {
              return Scaffold(
                body: controller.currentScreen,
                bottomNavigationBar: bottomNavigationBar(),
              );
            });
    });
  }

  Widget bottomNavigationBar() {
    return GetBuilder<ControlViewModel>(
        init: ControlViewModel(),
        builder: (controller) {
          return BottomNavigationBar(
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedLabelStyle:
                Styles.textStyle14.copyWith(color: Colors.black),
            selectedItemColor: Colors.black,
            onTap: (index) {
              controller.changeNavigatorIndex(index);
            },
            currentIndex: controller.navigatorIndex,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AssetsManager.exploreTabIcon,
                  height: 18.h,
                  width: 18.w,
                ),
                label: '',
                activeIcon: Column(
                  children: [
                    Text(
                      'Explore', //'Explore \n      .'
                      style: Styles.textStyle14.copyWith(color: Colors.black),
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      height: 5.h,
                      width: 5.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AssetsManager.cartTabIcon,
                  height: 18.h,
                  width: 18.w,
                ),
                label: '',
                activeIcon: Column(
                  children: [
                    Text(
                      'Cart', //'Cart \n    .'
                      style: Styles.textStyle14.copyWith(color: Colors.black),
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      height: 5.h,
                      width: 5.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AssetsManager.accountTabIcon,
                  height: 18.h,
                  width: 18.w,
                ),
                label: '',
                activeIcon: Column(
                  children: [
                    Text(
                      'Account', //'Account \n      .'
                      style: Styles.textStyle14.copyWith(color: Colors.black),
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      height: 5.h,
                      width: 5.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
