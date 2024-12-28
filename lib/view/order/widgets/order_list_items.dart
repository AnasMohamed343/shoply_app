import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/core/assets-manager.dart';
import 'package:shoply/core/common/widgets/custom_animation_loader_widget.dart';
import 'package:shoply/utils/helper_functions.dart';
import 'package:shoply/view/Cart_tab_view/cart_tab_view.dart';
import 'package:shoply/view/control_view.dart';
import 'package:shoply/view/order/widgets/custom_order_list_item.dart';
import 'package:shoply/view_model/order_viewmodel.dart';

class OrderListItems extends StatelessWidget {
  const OrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderViewModel());
    final h = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: controller.fetchUserOrders(),
        builder: (context, snapshot) {
          // nothing found widget
          final emptyWidget = CustomAnimationLoaderWidget(
            animationPath: AssetsManager.noDataFoundAnimation,
            showAction: true,
            actionText: Text('Let\'s fill it', style: Styles.textStyle18),
            onActionPressed: () => Get.to(
              () => ControlView(),
            ),
          );

          // helper function : handle loader, error and empty widget
          final response = HelperFunctions.checkMultiRecordState(
              snapshot: snapshot, nothingFound: emptyWidget);
          if (response != null) return response;

          final orders = snapshot.data!;
          return ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => SizedBox(
              height: h * 0.01,
            ),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return CustomOrderListItem(
                orderDate: order.formattedOrderDate,
                orderId: order.id,
                shippingDate: order.formattedDeliveryDate,
              );
            },
          );
        });
  }
}
