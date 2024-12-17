import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/utils/enum.dart';
import 'package:shoply/view/control_view.dart';

class CheckOutViewModel extends GetxController {
  int _index = 0;
  int get index => _index;

  Pages get pages => _pages;
  Pages _pages = Pages.deliveryTime;

  String? street1, street2, city, state, country;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  void changeIndex(int index) {
    if (index == 0 || index < 0) {
      _pages = Pages.deliveryTime;
      _index = index;
    } else if (index == 1) {
      _pages = Pages.addAddress;
      _index = index;
    } else if (index == 2) {
      formState.currentState!.save();
      if (formState.currentState!.validate()) {
        _pages = Pages.summary;
        _index = index;
      }
    } else if (index == 3) {
      Get.to(ControlView());
      _pages = Pages.deliveryTime;
      _index = 0;
    }
    update();
  }

  Color getColor(int index) {
    if (index == _index) {
      return kPrimaryColor;
    } else if (index < _index) {
      return kLightGrey;
    } else {
      return kLightGrey;
    }
  }
}
