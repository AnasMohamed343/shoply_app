import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/utils/enum.dart';
import 'package:shoply/view/widgets/custom_button.dart';
import 'package:shoply/view_model/checkout_viewmodel.dart';
import 'package:timelines/timelines.dart';

import 'checkout_widgets/add_address_widget.dart';
import 'checkout_widgets/delivery_time_widget.dart';
import 'checkout_widgets/summary_widget.dart';

class CheckoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return GetBuilder<CheckOutViewModel>(
        init: CheckOutViewModel(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: const Text(
                "Order Status",
                style: TextStyle(color: Colors.black),
              ),
            ),
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.only(
                  right: w * 0.02, left: w * 0.02, bottom: h * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Add a SizedBox to constrain the height of the Timeline
                  SingleChildScrollView(
                    child: SizedBox(
                      height: h * 0.17,
                      // child: Timeline.tileBuilder(
                      //   padding: EdgeInsets.symmetric(horizontal: h * 0.09),
                      //   theme: TimelineThemeData(
                      //     direction: Axis.horizontal, // Set horizontal layout
                      //     color: controller.getColor(controller.index),
                      //     indicatorTheme: IndicatorThemeData(
                      //         size: 20,
                      //         color: controller.getColor(controller.index)),
                      //     connectorTheme: ConnectorThemeData(
                      //         thickness: 4.0, color: kLightGrey),
                      //   ),
                      //   builder: TimelineTileBuilder.fromStyle(
                      //     contentsAlign: ContentsAlign.basic,
                      //     contentsBuilder: (context, index) => Padding(
                      //       padding: const EdgeInsets.all(15.0),
                      //       child: Text(
                      //         _processes[index],
                      //         style:
                      //             TextStyle(color: controller.getColor(index)),
                      //       ),
                      //     ),
                      //     // oppositeContentsBuilder: (context, index) => Padding(
                      //     //   padding: const EdgeInsets.all(20),
                      //     //   child: Text(
                      //     //     _content[index],
                      //     //     style: TextStyle(
                      //     //       fontWeight: FontWeight.bold,
                      //     //       color: controller.getColor(index),
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //     indicatorStyle: IndicatorStyle.dot,
                      //     connectorStyle: ConnectorStyle.solidLine,
                      //     itemCount: _processes.length,
                      //   ),
                      // ),
                      child: Timeline.tileBuilder(
                        scrollDirection: Axis.horizontal,
                        //padding: EdgeInsets.symmetric(horizontal: h * 0.09),
                        builder: TimelineTileBuilder.connected(
                          connectorBuilder: (context, index, connectorType) {
                            return SolidLineConnector(
                              color: controller
                                  .getColor(index), // Use dynamic index
                              thickness: 4.0,
                            );
                          },
                          indicatorBuilder: (context, index) {
                            return DotIndicator(
                              color: controller
                                  .getColor(index), // Use dynamic index
                              size: 20.0,
                            );
                          },
                          itemExtentBuilder: (_, __) =>
                              w * 0.3, // Set dynamic spacing
                          contentsBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              _processes[index],
                              style: TextStyle(
                                color: controller
                                    .getColor(index), // Use dynamic index
                              ),
                            ),
                          ),
                          itemCount: _processes.length,
                        ),
                      ),
                    ),
                  ),
                  // // Add additional content below if needed
                  // Expanded(
                  //   child: Center(
                  //       child: Text(
                  //     controller.index < _processes.length - 1
                  //         ? 'Next: ${_processes[controller.index + 1]}'
                  //         : 'Done',
                  //     style: const TextStyle(color: kPrimaryColor),
                  //   )),
                  // ),
                  controller.pages == Pages.deliveryTime
                      ? DeliveryTime()
                      : controller.pages == Pages.addAddress
                          ? AddAddress()
                          : Summary(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        controller.index == 0
                            ? const SizedBox()
                            : CustomButton(
                                fixedSize: Size(w * 0.45, h * 0.06),
                                buttonText: 'BACK',
                                onPressed: () {
                                  controller.changeIndex(controller.index - 1);
                                },
                                borderColor: kPrimaryColor,
                                foregroundColor: kPrimaryColor,
                                backgroundColor: Colors.white,
                              ),
                        CustomButton(
                          fixedSize: Size(w * 0.45, h * 0.06),
                          buttonText: 'NEXT',
                          onPressed: () {
                            controller.changeIndex(controller.index + 1);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

final _processes = [
  'Delivery',
  'Address',
  'Summer',
];
//
// final _content = [
//   '20/18',
//   '20/18',
//   '20/18',
//   '20/18',
//   '20/18',
// ];
