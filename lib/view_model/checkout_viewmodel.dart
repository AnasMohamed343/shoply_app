import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/assets-manager.dart';
import 'package:shoply/core/common/widgets/custom_section_heading.dart';
import 'package:shoply/model/payment_method_model.dart';
import 'package:shoply/utils/enum.dart';
import 'package:shoply/view/checkout/widgets/custom_payment_tile_widget.dart';
import 'package:shoply/view/control_view.dart';

class CheckOutViewModel extends GetxController {
  static CheckOutViewModel get instance => Get.put(CheckOutViewModel());

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value =
        PaymentMethodModel(name: 'Paypal', image: AssetsManager.paypalLogo);
    super.onInit();
  }

  int _index = 0;
  int get index => _index;

  Pages get pages => _pages;
  Pages _pages = Pages.deliveryTime;

  //String? street1, street2, city, state, country;

  //GlobalKey<FormState> formState = GlobalKey<FormState>();

  void changeIndex(int index) {
    if (index == 0 || index < 0) {
      _pages = Pages.deliveryTime;
      _index = index;
    }
    // else if (index == 1) {
    //   _pages = Pages.addAddress;
    //   _index = index;
    // }
    else if (index == 1) {
      // formState.currentState!.save();
      // if (formState.currentState!.validate()) {
      //   _pages = Pages.summary;
      //   _index = index;
      // }
      _pages = Pages.summary;
      _index = index;
    } else if (index == 2) {
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

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSectionHeading(title: 'Select Payment Method'),
              SizedBox(
                height: 10.h,
              ),
              CustomPaymentTileWidget(
                  paymentMethod: PaymentMethodModel(
                      name: 'Paypal', image: AssetsManager.paypalLogo)),
              SizedBox(
                height: 10.h,
              ),
              CustomPaymentTileWidget(
                  paymentMethod: PaymentMethodModel(
                      name: 'Credit Card',
                      image: AssetsManager.creditCardLogo)),
              SizedBox(
                height: 10.h,
              ),
              CustomPaymentTileWidget(
                  paymentMethod: PaymentMethodModel(
                      name: 'Master Card',
                      image: AssetsManager.masterCardLogo)),
              SizedBox(
                height: 10.h,
              ),
              CustomPaymentTileWidget(
                  paymentMethod: PaymentMethodModel(
                      name: 'Visa Card', image: AssetsManager.visaCardLogo)),
            ],
          ),
        ),
      ),
    );
  }
}
