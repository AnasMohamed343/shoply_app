// import 'package:shoply/model/address_model.dart';
// import 'package:shoply/model/cart_product_model.dart';
//
// class OrderModel {
//   String? userId, dateTime;
//   AddressModel? address;
//   List<CartProductModel>? products;
//
//   OrderModel({
//     this.userId,
//     this.dateTime,
//     this.address,
//     this.products,
//   });
//
//   OrderModel.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     dateTime = json['dateTime'];
//     address =
//         json['address'] != null ? AddressModel.fromJson(json['address']) : null;
//     if (json['products'] != null) {
//       products = <CartProductModel>[];
//       json['products'].forEach((v) {
//         products!.add(CartProductModel.fromJson(v));
//       });
//     }
//     // if (json['products'] != null) {
//     //   products = <CartProductModel>[];
//     //   json['products'].forEach((v) {
//     //     products!.add(CartProductModel.fromJson(v));
//     //   });
//     // }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['userId'] = userId;
//     data['dateTime'] = dateTime;
//     if (address != null) {
//       data['address'] = address!.toJson();
//     }
//     if (products != null) {
//       data['products'] = products!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoply/model/address_model.dart';
import 'package:shoply/model/cart_product_model.dart';
import 'package:shoply/utils/enum.dart';
import 'package:shoply/utils/helper_functions.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalPrice;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartProductModel> items;

  OrderModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.totalPrice,
    required this.orderDate,
    this.paymentMethod = 'PayPal',
    this.address,
    this.deliveryDate,
    required this.items,
  });

  String get formattedOrderDate => HelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? HelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
          ? 'Shipment on the way'
          : 'Processing';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(), // convert enum to string
      'totalPrice': totalPrice,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'address': address?.toJson(), // convert address model to map
      'deliveryDate': deliveryDate,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    // i used snapShot here to use it directly in the func fetchUserOrders instead of using datatype stream
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      id: data['id'] as String,
      userId: data['userId'] as String,
      status: OrderStatus.values.firstWhere(
        (element) => element.toString() == data['status'],
      ),
      totalPrice: data['totalPrice'] as double,
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      paymentMethod: data['paymentMethod'] as String,
      address: AddressModel.fromJson(data['address'] as Map<String, dynamic>),
      deliveryDate: data['deliveryDate'] == null
          ? null
          : (data['deliveryDate'] as Timestamp).toDate(),
      items: (data['items'] as List<dynamic>)
          .map((itemData) =>
              CartProductModel.fromJson(itemData as Map<String, dynamic>))
          .toList(),
    );
  }
}
