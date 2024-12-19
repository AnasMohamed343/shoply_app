import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/model/payment_method_model.dart';
import 'package:shoply/view_model/checkout_viewmodel.dart';

class CustomPaymentTileWidget extends StatelessWidget {
  CustomPaymentTileWidget({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;
  @override
  Widget build(BuildContext context) {
    final controller = CheckOutViewModel.instance;
    final double h = MediaQuery.of(context).size.height;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      leading: Container(
        height: h * 0.05,
        width: h * 0.06,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: kLightGrey,
          ),
        ),
        child: Image(
          image: AssetImage(
            paymentMethod.image ?? '',
          ),
          fit: BoxFit.contain,
        ),
      ),
      title: Text(
        paymentMethod.name ?? '',
        style: Styles.textStyle18.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_right,
        color: kPrimaryColor,
      ),
    );
  }
}
