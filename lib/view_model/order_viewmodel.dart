import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoply/core/assets-manager.dart';
import 'package:shoply/core/common/custom_full_screen_loader.dart';
import 'package:shoply/core/common/custom_success_screen.dart';
import 'package:shoply/core/service/firestore_order.dart';
import 'package:shoply/model/order_model.dart';
import 'package:shoply/utils/enum.dart';
import 'package:shoply/view/Explore_tab_view/explore_tab_view.dart';
import 'package:shoply/view/control_view.dart';
import 'package:shoply/view_model/address_view_model.dart';
import 'package:shoply/view_model/auth_view_model.dart';
import 'package:shoply/view_model/cart_viewmodel.dart';
import 'package:shoply/view_model/checkout_viewmodel.dart';
import 'package:shoply/view_model/delivery_viewmodel.dart';

class OrderViewModel extends GetxController {
  static OrderViewModel get instance => Get.put(OrderViewModel());

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  // Variables
  final cartController = CartViewModel.instance;
  final addressController = AddressViewModel.instance;
  final checkoutController = CheckOutViewModel.instance;
  final deliveryController = DeliveryViewModel.instance;
  final orderRepository = Get.put(FireStoreOrder());

  // Fetch User's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      Get.snackbar(
        'Order not found',
        e.toString(),
      );
      return [];
    }
  }

  // add methods for order processing
  void processOrder(double totalPrice, Delivery selectedDelivery) async {
    try {
      // start loader
      //_loading.value = true;
      CustomFullScreenLoader.openLoadingDialog(
          'Processing your order..', AssetsManager.loadingAnimation);

      // get user authentication id
      final userId = AuthViewModel.instance.authUser.uid;
      if (userId.isEmpty) return;

      // calculate the selected delivery time
      final orderDate = DateTime.now();
      final deliveryTime =
          deliveryController.calculateDeliveryTime(orderDate, selectedDelivery);

      // add order details
      final order = OrderModel(
        // generate a unique id for the orderDate
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalPrice: totalPrice,
        orderDate: orderDate,
        paymentMethod:
            checkoutController.selectedPaymentMethod.value.name ?? '',
        address: addressController.selectedAddress.value,
        deliveryDate:
            deliveryTime, //checkoutController.selectedDeliveryDate.value,
        items: cartController.cartProductList ?? [],
      );

      // save the order to firestore
      await orderRepository.saveOrder(order, userId);

      // update the cart status
      cartController.clearCart();

      // stop loader
      CustomFullScreenLoader.stopLoadingDialog();

      //show success screen
      Get.off(() => CustomSuccessScreen(
          title: 'Payment Success!',
          subtitle: 'Your item will be shipped soon!',
          onPressed: () => Get.to(ControlView())));
    } catch (e) {
      Get.snackbar(
        'Error processing order',
        e.toString(),
      );
    }
  }
}
