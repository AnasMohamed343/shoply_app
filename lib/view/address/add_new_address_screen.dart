import 'package:flutter/material.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/core/common/widgets/custom_app_bar.dart';
import 'package:shoply/view/widgets/custom_button.dart';
import 'package:shoply/view/widgets/custom_text_form_field.dart';
import 'package:shoply/view_model/address_view_model.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressViewModel.instance;
    final double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(title: 'Add New Address'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextFormField(
                  controller: controller.name,
                  validator: (p0) => p0!.isEmpty ? 'Name is Required' : null,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: kGreyColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.person),
                  fieldName: 'Name',
                  hintText: 'Name',
                ),
                SizedBox(
                  height: h * 0.01,
                ),
                CustomTextFormField(
                  controller: controller.phoneNumber,
                  validator: (p0) =>
                      p0!.isEmpty ? 'Phone Number is Required' : null,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: kGreyColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.mobile_screen_share),
                  fieldName: 'Phone Number',
                  hintText: 'Phone Number',
                ),
                SizedBox(
                  height: h * 0.01,
                ),
                CustomTextFormField(
                  controller: controller.street,
                  validator: (p0) => p0!.isEmpty ? 'Street is Required' : null,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: kGreyColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.stacked_line_chart_outlined),
                  fieldName: 'Street',
                  hintText: 'Street',
                ),
                SizedBox(
                  height: h * 0.01,
                ),
                CustomTextFormField(
                  controller: controller.city,
                  validator: (p0) => p0!.isEmpty ? 'City is Required' : null,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: kGreyColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.location_city),
                  fieldName: 'City',
                  hintText: 'City',
                ),
                SizedBox(
                  height: h * 0.01,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: controller.state,
                        validator: (p0) =>
                            p0!.isEmpty ? 'State is Required' : null,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: kGreyColor.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.airplanemode_active),
                        fieldName: 'State',
                        hintText: 'State',
                      ),
                    ),
                    SizedBox(
                      width: h * 0.01,
                    ),
                    Expanded(
                      child: CustomTextFormField(
                        controller: controller.country,
                        validator: (p0) =>
                            p0!.isEmpty ? 'Country is Required' : null,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: kGreyColor.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.location_city),
                        fieldName: 'Country',
                        hintText: 'Country',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: h * 0.03,
                ),
                // controller.loading.value
                //     ? const CircularProgressIndicator(
                //         color: kPrimaryColor,
                //       ) :
                CustomButton(
                  borderRadius: 10,
                  fixedSize: Size(double.infinity, h * 0.06),
                  buttonText: Text('Save', style: Styles.textStyle14),
                  onPressed: () {
                    controller.addNewAddress();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
