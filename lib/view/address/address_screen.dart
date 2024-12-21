import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/common/widgets/custom_app_bar.dart';
import 'package:shoply/utils/helper_functions.dart';
import 'package:shoply/view/address/add_new_address_screen.dart';
import 'package:shoply/view/address/widgets/custom_address_item.dart';
import 'package:shoply/view_model/address_view_model.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressViewModel());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Addresses'),
      body: SingleChildScrollView(
        child: Obx(
          () => FutureBuilder(
            key: Key(controller.refreshData.value.toString()),
            future: controller.getAllUserAddresses(),
            builder: (context, snapshot) {
              // helper function: to handle loader, error and nothing found
              final response =
                  HelperFunctions.checkMultiRecordState(snapshot: snapshot);
              if (response != null) return response;

              final addresses = snapshot.data!;
              return ListView.builder(
                itemCount: addresses.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => CustomAddressItem(
                  address: addresses[index],
                  onTap: () => controller.selectAddress(addresses[index]),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            Get.to(const AddNewAddressScreen());
          }),
    );
  }
}
