import 'package:shoply/view_model/auth_view_model.dart';
import 'package:get/get.dart';
import 'package:shoply/view_model/cart_viewmodel.dart';
import 'package:shoply/view_model/checkout_viewmodel.dart';
import 'package:shoply/view_model/control_view_model.dart';
import 'package:shoply/view_model/explore_screen_view_model.dart';

class Binding extends Bindings {
  //Binding = Dependency Injection
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => ControlViewModel());
    Get.lazyPut(() => ExploreScreenViewModel());
    Get.lazyPut(() => CartViewModel());
    Get.lazyPut(() => CheckOutViewModel());
  }
}
