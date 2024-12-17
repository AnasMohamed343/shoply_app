import 'package:shoply/model/address_model.dart';
import 'package:shoply/model/cart_product_model.dart';

class OrderModel {
  String? userId, dateTime;
  AddressModel? address;
  List<CartProductModel>? products;

  OrderModel({
    this.userId,
    this.dateTime,
    this.address,
    this.products,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    dateTime = json['dateTime'];
    address =
        json['address'] != null ? AddressModel.fromJson(json['address']) : null;
    if (json['products'] != null) {
      products = <CartProductModel>[];
      json['products'].forEach((v) {
        products!.add(CartProductModel.fromJson(v));
      });
    }
    // if (json['products'] != null) {
    //   products = <CartProductModel>[];
    //   json['products'].forEach((v) {
    //     products!.add(CartProductModel.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['dateTime'] = dateTime;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
