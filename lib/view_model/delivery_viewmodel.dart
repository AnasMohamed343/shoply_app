import 'package:get/get.dart';
import 'package:shoply/utils/enum.dart';

class DeliveryViewModel extends GetxController {
  static DeliveryViewModel get instance => Get.put(DeliveryViewModel());
  Rx<Delivery> selectedDelivery = Delivery.StandardDelivery.obs;

  void updateDelivery(Delivery delivery) {
    selectedDelivery.value = delivery;
  }

  DateTime calculateDeliveryTime(
      DateTime orderDate, Delivery selectedDelivery) {
    switch (selectedDelivery) {
      case Delivery.StandardDelivery:
        return orderDate
            .add(const Duration(days: 5)); // 3-5 business days (max 5)
      case Delivery.NextDayDelivery:
        return orderDate.add(const Duration(days: 1)); // Next day
      case Delivery.NominatedDelivery:
        // Example: Adding 7 days, you can update this logic based on a user-selected date.
        return orderDate.add(const Duration(days: 7));
      default:
        return orderDate; // Default to order date if no selection
    }
  }
}
