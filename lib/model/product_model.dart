import 'package:flutter/material.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/utils/extention.dart';

class ProductModel {
  String? productId, name, description, image, price, size, productCategory;
  Color? color;

  ProductModel(
      {this.name,
      this.description,
      this.image,
      this.price,
      this.color,
      this.size,
      this.productCategory,
      this.productId});

  ProductModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    description = json['description'] ?? '';
    image = json['image'] ?? '';
    price = json['price'] ?? '';
    color = json['color'] != null
        ? HexColor.fromHex(json['color'])
        : Colors.transparent; //color = HexColor.fromHex(json['color']);
    size = json['size'] ?? '';
    productId = json['productId'] ?? '';
    productCategory = json[kProductCategory] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'color': color?.toHex(),
      'size': size,
      'productId': productId,
      kProductCategory: productCategory
    };
  }
}
