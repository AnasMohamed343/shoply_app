import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/model/address_model.dart';
import 'package:shoply/view_model/address_view_model.dart';

class CustomAddressItem extends StatelessWidget {
  final AddressModel address;
  final VoidCallback onTap;
  const CustomAddressItem(
      {super.key, required this.address, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final controller = AddressViewModel.instance;
    //final double h = MediaQuery.of(context).size.height;
    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;
      return InkWell(
        onTap: onTap,
        child: Container(
          //height: h * 0.2,
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: selectedAddress
                ? kPrimaryColor.withOpacity(0.5)
                : Colors.transparent,
            border: Border.all(
              color: selectedAddress
                  ? Colors.transparent
                  : kGreyColor.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Positioned(
                right: 5,
                top: 0,
                child: Icon(
                  selectedAddress ? Icons.check_circle : null,
                  color: selectedAddress ? kPrimaryDarkColor : null,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name ?? '',
                    style: Styles.textStyle16.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    address.phoneNumber ?? '',
                    style: Styles.textStyle16,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    address.toString(),
                    style: Styles.textStyle16,
                    softWrap:
                        true, // By default, softWrap is true, meaning the text will wrap to the next line if it doesn’t fit in the available space.
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
