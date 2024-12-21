// import 'package:flutter/material.dart';
// import 'package:shoply/constants.dart';
// import 'package:shoply/core/Styles.dart';
// import 'package:shoply/utils/enum.dart';
//
// class DeliveryTime extends StatefulWidget {
//   @override
//   State<DeliveryTime> createState() => _DeliveryTimeState();
// }
//
// class _DeliveryTimeState extends State<DeliveryTime> {
//   Delivery delivery = Delivery.StandardDelivery;
//
//   @override
//   Widget build(BuildContext context) {
//     final double h = MediaQuery.of(context).size.height;
//     final double w = MediaQuery.of(context).size.width;
//     return Expanded(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: h * 0.01,
//           ),
//           RadioListTile<Delivery>(
//             value: Delivery.StandardDelivery,
//             groupValue: delivery,
//             onChanged: (Delivery? value) {
//               setState(() {
//                 delivery = value!;
//               });
//             },
//             title: Text(
//               'Standard Delivery',
//               style: Styles.textStyle24.copyWith(
//                 fontWeight: FontWeight.normal,
//               ),
//             ),
//             subtitle: Text(
//               'Order will be delivered between 3 - 5 business days',
//               style: Styles.textStyle18,
//             ),
//             activeColor: kPrimaryColor,
//           ),
//           SizedBox(
//             height: h * 0.04,
//           ),
//           RadioListTile<Delivery>(
//             value: Delivery.NextDayDelivery,
//             groupValue: delivery,
//             onChanged: (Delivery? value) {
//               setState(() {
//                 delivery = value!;
//               });
//             },
//             title: Text(
//               'Next Day Delivery',
//               style: Styles.textStyle24.copyWith(
//                 fontWeight: FontWeight.normal,
//               ),
//             ),
//             subtitle: Text(
//               'Place your Order before 6pm and your items will be delivered the next day. ',
//               style: Styles.textStyle18,
//             ),
//             activeColor: kPrimaryColor,
//           ),
//           SizedBox(
//             height: h * 0.04,
//           ),
//           RadioListTile<Delivery>(
//             value: Delivery.NominatedDelivery,
//             groupValue: delivery,
//             onChanged: (Delivery? value) {
//               setState(() {
//                 delivery = value!;
//               });
//             },
//             title: Text(
//               'Nominated Delivery',
//               style: Styles.textStyle24.copyWith(
//                 fontWeight: FontWeight.normal,
//               ),
//             ),
//             subtitle: Text(
//               'Pick a particular date from the calendar and order will be delivered on selected date.',
//               style: Styles.textStyle18,
//             ),
//             activeColor: kPrimaryColor,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/utils/enum.dart';
import 'package:shoply/view_model/delivery_viewmodel.dart';

class DeliveryTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deliveryController = DeliveryViewModel.instance;

    return Expanded(
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RadioListTile<Delivery>(
              value: Delivery.StandardDelivery,
              groupValue: deliveryController.selectedDelivery.value,
              onChanged: (Delivery? value) {
                deliveryController.updateDelivery(value!);
              },
              title: Text(
                'Standard Delivery',
                style: Styles.textStyle24.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),
              subtitle: Text(
                'Order will be delivered between 3 - 5 business days',
                style: Styles.textStyle18,
              ),
              activeColor: kPrimaryColor,
            ),
            RadioListTile<Delivery>(
              value: Delivery.NextDayDelivery,
              groupValue: deliveryController.selectedDelivery.value,
              onChanged: (Delivery? value) {
                deliveryController.updateDelivery(value!);
              },
              title: Text(
                'Next Day Delivery',
                style: Styles.textStyle24.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),
              subtitle: Text(
                'Place your order before 6pm and your items will be delivered the next day.',
                style: Styles.textStyle18,
              ),
              activeColor: kPrimaryColor,
            ),
            RadioListTile<Delivery>(
              value: Delivery.NominatedDelivery,
              groupValue: deliveryController.selectedDelivery.value,
              onChanged: (Delivery? value) {
                deliveryController.updateDelivery(value!);
              },
              title: Text(
                'Nominated Delivery',
                style: Styles.textStyle24.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),
              subtitle: Text(
                'Pick a particular date from the calendar and order will be delivered on the selected date.',
                style: Styles.textStyle18,
              ),
              activeColor: kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
