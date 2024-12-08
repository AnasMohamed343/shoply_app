import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/view/account_tab_view/account_tab_view.dart';
import 'package:shoply/view/control_view.dart';
import 'package:shoply/view_model/checkout_viewmodel.dart';
import 'package:timelines/timelines.dart';

import 'checkout_widgets/add_address_widget.dart';
import 'checkout_widgets/delivery_time_widget.dart';
import 'checkout_widgets/summary_widget.dart';

class CheckoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
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
            body: Column(
              children: [
                // Add a SizedBox to constrain the height of the Timeline
                SingleChildScrollView(
                  child: SizedBox(
                    height: h * 0.17,
                    child: Timeline.tileBuilder(
                      theme: TimelineThemeData(
                        direction: Axis.horizontal, // Set horizontal layout
                        color: controller.getColor(controller.index),
                        indicatorTheme:
                            IndicatorThemeData(size: 20, color: kPrimaryColor),
                        connectorTheme: ConnectorThemeData(
                            thickness: 4.0, color: kGreyColor),
                      ),
                      builder: TimelineTileBuilder.fromStyle(
                        contentsAlign: ContentsAlign.basic,
                        contentsBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            _processes[index],
                            style: const TextStyle(color: kPrimaryColor),
                          ),
                        ),
                        oppositeContentsBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            _content[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: controller.getColor(index),
                            ),
                          ),
                        ),
                        indicatorStyle: IndicatorStyle.dot,
                        connectorStyle: ConnectorStyle.dashedLine,
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
                        : Summary()
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                controller.changeIndex(controller.index + 1);
                // setState(() {
                //   if (_processIndex < _processes.length - 1) {
                //     _processIndex++;
                //   } else {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => ControlView(),
                //       ),
                //     );
                //   }
                // });
              },
              backgroundColor: inProgressColor,
              child: Icon(Icons.skip_next, color: Colors.white, size: 30.sp),
            ),
          );
        });
  }
}

final _processes = [
  'Order Signed',
  'Order Processed',
  'Shipped ',
  'Out for delivery ',
  'Delivered ',
];

final _content = [
  '20/18',
  '20/18',
  '20/18',
  '20/18',
  '20/18',
];
