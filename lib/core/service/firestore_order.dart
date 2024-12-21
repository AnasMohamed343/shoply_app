import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/model/order_model.dart';
import 'package:shoply/view_model/auth_view_model.dart';

class FireStoreOrder extends GetxController {
  static FireStoreOrder get instance => Get.find();

  //  variables
  final _db = FirebaseFirestore.instance;

  //  methods

  // get all orders related to current user
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthViewModel.instance.authUser.uid;
      if (userId.isEmpty)
        throw 'unable to find user information, try again in few minutes';

      final result = await _db
          .collection(kUserCollection)
          .doc(userId)
          .collection(kOrdersCollection)
          .get();
      return result.docs
          .map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching order information, try again later';
    }
  }

  // store new user order
  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db
          .collection(kUserCollection)
          .doc(userId)
          .collection(kOrdersCollection)
          .add(order.toJson());
    } catch (e) {
      throw 'Something went wrong while saving order information, try again later';
    }
  }
}
