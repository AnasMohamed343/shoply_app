// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shoply/view/Cart_tab_view/cart_tab_view.dart';
// import 'package:shoply/view/Explore_tab_view/explore_tab_view.dart';
// import 'package:shoply/view/account_tab_view/account_tab_view.dart';
// import 'package:shoply/view/home_Screen.dart';
// import 'package:shoply/view_model/explore_screen_view_model.dart';
//
// class ControlViewModel extends GetxController {
//   int _navigatorIndex = 0;
//
//   int get navigatorIndex => _navigatorIndex;
//
//   Widget _currentScreen = ExploreTabView();
//
//   Widget get currentScreen => _currentScreen;
//
//   // final ExploreScreenViewModel _exploreScreenViewModel =
//   //     Get.put(ExploreScreenViewModel()); // Initialize once
//
//   void changeNavigatorIndex(int selectedIndex) {
//     _navigatorIndex = selectedIndex;
//     switch (selectedIndex) {
//       case 0:
//         _currentScreen = ExploreTabView();
//         break;
//       case 1:
//         _currentScreen = CartTabView();
//         break;
//       case 2:
//         _currentScreen = AccountTabView();
//         break;
//     }
//     update();
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoply/view/Cart_tab_view/cart_tab_view.dart';
import 'package:shoply/view/Explore_tab_view/explore_tab_view.dart';
import 'package:shoply/view/account_tab_view/account_tab_view.dart';

// class ControlViewModel extends GetxController {
//   // Tracks the current selected index
//   int _navigatorIndex = 0;
//   int get navigatorIndex => _navigatorIndex;
//
//   // Screens initialized once and reused
//   final List<Widget> _screens = [
//     ExploreTabView(),
//     CartTabView(),
//     AccountTabView(),
//   ];
//
//   // Returns the current screen based on the selected index
//   Widget get currentScreen => _screens[_navigatorIndex];
//
//   // Updates the index and triggers a rebuild
//   void changeNavigatorIndex(int selectedIndex) {
//     _navigatorIndex = selectedIndex;
//     update(); // Notify GetBuilder to rebuild widgets
//   }
// }

class ControlViewModel extends GetxController {
  // Current selected index for BottomNavigationBar
  int navigatorIndex = 0;

  // List of screens for navigation
  final List<Widget> _screens = [
    ExploreTabView(),
    CartTabView(),
    AccountTabView(),
  ];

  // Current screen displayed
  Widget currentScreen = ExploreTabView();

  // Change the selected navigation index and update the current screen
  void changeNavigatorIndex(int index) {
    navigatorIndex = index;
    currentScreen = _screens[index];
    update(); // Notify listeners to rebuild the UI
  }
}
