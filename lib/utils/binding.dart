import 'package:shoply/view_model/address_view_model.dart';
import 'package:shoply/view_model/auth_view_model.dart';
import 'package:get/get.dart';
import 'package:shoply/view_model/cart_viewmodel.dart';
import 'package:shoply/view_model/checkout_viewmodel.dart';
import 'package:shoply/view_model/control_view_model.dart';
import 'package:shoply/view_model/dashboard_viewmodel.dart';
import 'package:shoply/view_model/delivery_viewmodel.dart';
import 'package:shoply/view_model/explore_screen_view_model.dart';
import 'package:shoply/view_model/notification_viewmodel.dart';
import 'package:shoply/view_model/order_viewmodel.dart';
import 'package:shoply/view_model/user_data_viewmodel.dart';

class Binding extends Bindings {
  //Binding = Dependency Injection
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    //Get.lazyPut(() => ControlViewModel());
    Get.put(ControlViewModel());
    Get.put(ExploreScreenViewModel());
    Get.lazyPut(() => CartViewModel());
    Get.lazyPut(() => CheckOutViewModel());
    Get.lazyPut(() => NotificationViewModel());
    Get.lazyPut(() => AddressViewModel());
    Get.lazyPut(() => DeliveryViewModel());
    Get.lazyPut(() => OrderViewModel());
    Get.lazyPut(() => DashboardViewModel());
    Get.lazyPut(() => UserDataViewModel());
  }
}
