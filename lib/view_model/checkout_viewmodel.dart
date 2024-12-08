import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/view/control_view.dart';

class CheckOutViewModel extends GetxController {
  int _index = 0;
  int get index => _index;

  Pages get pages => _pages;
  Pages _pages = Pages.deliveryTime;

  void changeIndex(int index) {
    _index = index;
    if (_index == 1) {
      _pages = Pages.addAddress;
    } else if (_index == 2) {
      _pages = Pages.summary;
    } else if (_index == 3) {
      Get.to(() => ControlView());
    }
    update();
  }

  Color getColor(int index) {
    if (index == _index) {
      return inProgressColor;
    } else if (index < _index) {
      return kPrimaryColor;
    } else {
      return todoColor;
    }
  }
}
