import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoply/view/Cart_tab_view/cart_tab_view.dart';
import 'package:shoply/view/Explore_tab_view/explore_tab_view.dart';
import 'package:shoply/view/account_tab_view/account_tab_view.dart';
import 'package:shoply/view/home_Screen.dart';
import 'package:shoply/view_model/explore_screen_view_model.dart';

class ControlViewModel extends GetxController {
  int _navigatorIndex = 0;

  int get navigatorIndex => _navigatorIndex;

  Widget _currentScreen = ExploreTabView();

  Widget get currentScreen => _currentScreen;

  // final ExploreScreenViewModel _exploreScreenViewModel =
  //     Get.put(ExploreScreenViewModel()); // Initialize once

  void changeNavigatorIndex(int selectedIndex) {
    _navigatorIndex = selectedIndex;
    switch (selectedIndex) {
      case 0:
        _currentScreen = ExploreTabView();
        break;
      case 1:
        _currentScreen = CartTabView();
        break;
      case 2:
        _currentScreen = AccountTabView();
        break;
    }
    update();
  }
}
