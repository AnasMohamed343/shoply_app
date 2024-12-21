// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:shoply/constants.dart';
// import 'package:shoply/core/Styles.dart';
// import 'package:shoply/view/widgets/custom_text_form_field.dart';
// import 'package:shoply/view_model/checkout_viewmodel.dart';
//
// class AddAddress extends StatelessWidget {
//   const AddAddress({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final double h = MediaQuery.of(context).size.height;
//     final double w = MediaQuery.of(context).size.width;
//     return GetBuilder<CheckOutViewModel>(
//         init: CheckOutViewModel(),
//         builder: (controller) {
//           return Form(
//             key: controller.formState,
//             child: Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 15.w),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     //crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Row(
//                         children: [
//                           Checkbox(
//                             materialTapTargetSize:
//                                 MaterialTapTargetSize.shrinkWrap,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                             value: true,
//                             onChanged: (value) {},
//                             activeColor: kPrimaryColor,
//                           ),
//                           Text(
//                             "Billing Address is the same as\ndelivery address",
//                             style: Styles.textStyle20,
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: h * 0.03,
//                       ),
//                       CustomTextFormField(
//                         fieldName: 'Street 1',
//                         fieldNameColor: kGreyColor,
//                         onSave: (value) {
//                           controller.street1 = value;
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your street 1';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(
//                         height: h * 0.04,
//                       ),
//                       CustomTextFormField(
//                         fieldName: 'Street 2',
//                         fieldNameColor: kGreyColor,
//                         onSave: (value) {
//                           controller.street2 = value;
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your street 2';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(
//                         height: h * 0.04,
//                       ),
//                       CustomTextFormField(
//                         fieldName: 'City',
//                         fieldNameColor: kGreyColor,
//                         onSave: (value) {
//                           controller.city = value;
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your city';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(
//                         height: h * 0.04,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: CustomTextFormField(
//                               fieldName: 'State',
//                               fieldNameColor: kGreyColor,
//                               onSave: (value) {
//                                 controller.state = value;
//                               },
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter your state';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                           SizedBox(
//                             width: w * 0.07,
//                           ),
//                           Expanded(
//                             child: CustomTextFormField(
//                               fieldName: 'Country',
//                               fieldNameColor: kGreyColor,
//                               onSave: (value) {
//                                 controller.country = value;
//                               },
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter your country';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }
