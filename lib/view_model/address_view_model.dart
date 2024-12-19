import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/common/widgets/custom_section_heading.dart';
import 'package:shoply/core/service/firestore_address.dart';
import 'package:shoply/model/address_model.dart';

class AddressViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  static AddressViewModel get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;

  // fetch all user specific addresses
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await FireStoreAddress().fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      Get.snackbar(
        'Address not found',
        e.toString(),
      );
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async {
          return false;
        },
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        ),
      );

      //clear the selected field
      if (selectedAddress.value.id.isNotEmpty) {
        await FireStoreAddress()
            .updateSelectedField(selectedAddress.value.id, false);
      }

      //assign the new selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      //set the "selected" field to true for the new selected address
      await FireStoreAddress().updateSelectedField(newSelectedAddress.id, true);

      // close the default dialog after the address is selected
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error in selecting address',
        e.toString(),
      );
    }
  }

  Future addNewAddress() async {
    try {
      //start loading
      _loading.value = true;

      //check internet connectivity

      //form validation
      if (!addressFormKey.currentState!.validate()) {
        _loading.value = false;
        return;
      }

      //save address data
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );
      final id = await FireStoreAddress().addAddress(address);

      //update the selected address status
      address.id = id;
      await selectAddress(
          address); //to select the new address automatically when it is added

      //remove loader
      _loading.value = false;

      //show success message
      Get.snackbar(
        'Address added successfully',
        'Your address has been added successfully',
      );

      //refresh addresses data
      refreshData.toggle();

      //reset fields
      resetFormFields();
      //redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      //remove loader
      _loading.value = false;
      Get.snackbar(
        'Error in adding address',
        e.toString(),
      );
    }
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }

  // Future<dynamic> selectNewAddressPopUp(BuildContext context) {
  //   return showModalBottomSheet(
  //     isScrollControlled: true,
  //     showDragHandle: true,
  //     context: context,
  //     builder: (context) => Container(
  //       padding: EdgeInsets.all(15.h),
  //       child: Column(
  //         children: [
  //           CustomSectionHeading(title: 'Select Address'),
  //           FutureBuilder(future: getAllUserAddresses(),
  //               builder: (context, snapshot) {
  //                 return ListView.builder(
  //                   itemCount: snapshot.data!.length,
  //                   shrinkWrap: true,
  //                     itemBuilder: (context, index) {
  //
  //                 });
  //               },),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
