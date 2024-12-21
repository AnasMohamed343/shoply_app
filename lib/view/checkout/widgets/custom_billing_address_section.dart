import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/core/common/widgets/custom_section_heading.dart';
import 'package:shoply/view_model/address_view_model.dart';
import 'package:shoply/view_model/checkout_viewmodel.dart';

class CustomBillingAddressSection extends StatelessWidget {
  const CustomBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(CheckOutViewModel());
    final addressController = AddressViewModel.instance;
    final double h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        CustomSectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () => addressController.selectNewAddressPopUp(context),
        ),
        SizedBox(
          height: h * 0.01,
        ),
        Obx(
          () => addressController.selectedAddress.value.id.isEmpty ||
                  addressController.selectedAddress.value.id == ''
              ? Text(
                  'Select an address',
                  style: Styles.textStyle16,
                  textAlign: TextAlign.start,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: kGreyColor,
                          size: 16.sp,
                        ),
                        SizedBox(
                          width: h * 0.01,
                        ),
                        Text(
                          addressController.selectedAddress.value.phoneNumber ??
                              '',
                          style: Styles.textStyle16,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: kGreyColor,
                          size: 16.sp,
                        ),
                        SizedBox(
                          width: h * 0.01,
                        ),
                        Flexible(
                          child: Text(
                            addressController.selectedAddressToString,
                            style: Styles.textStyle16,
                            softWrap: true,
                            overflow: TextOverflow
                                .visible, // Allows the text to expand instead of clipping
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
