import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoply/core/service/database/cart_database_helper.dart';
import 'package:shoply/model/cart_product_model.dart';

class CartViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  List<CartProductModel>? _cartProductList = [];
  List<CartProductModel>? get cartProductList => _cartProductList;

  var dbHelper = CartDatabaseHelper.db;

  CartViewModel() {
    getAllProduct();
  }

  String get getTotalPrice {
    double total = 0.0;
    _cartProductList?.forEach((element) {
      total += element.price?.toDouble() *
          element
              .quantity!; // or //total += (double.parse(element.price!) * element.quantity!);
      // update(); // it's made this error (setState() or markNeedsBuild() called during build), when i use update() here.
    });
    return total.toStringAsFixed(2);
  }

  getAllProduct() async {
    _loading.value = true;

    _cartProductList = await dbHelper.getAllProduct();
    _loading.value = false;
    update();
  }

  addProductToCart(CartProductModel cartProductModel) async {
    for (int i = 0; i < _cartProductList!.length; i++) {
      if (_cartProductList![i].productId == cartProductModel.productId) {
        return;
      }
    }
    await dbHelper.insert(cartProductModel);
    _cartProductList?.add(cartProductModel);
    update();
  }

  increaseQuantity(int index) async {
    _cartProductList?[index].quantity =
        (_cartProductList?[index].quantity ?? 0) + 1;
    //total += _cartProductList?[index].price?.toDouble() * element.quantity!;
    await dbHelper.updateProduct(_cartProductList![index]);
    update();
  }

  decreaseQuantity(int index) async {
    _cartProductList?[index].quantity =
        (_cartProductList?[index].quantity ?? 0) - 1;
    //total += _cartProductList?[index].price?.toDouble() * element.quantity!;
    await dbHelper.updateProduct(_cartProductList![index]);
    update();
  }

  deleteProduct(int index) async {
    await dbHelper.deleteProduct(_cartProductList![index].productId!);
    _cartProductList?.removeAt(index);
    update();
  }

  bool isProductInCart(String productId) {
    for (int i = 0; i < _cartProductList!.length; i++) {
      if (_cartProductList![i].productId == productId) {
        return true;
      }
    }
    return false;
  }
}

extension on String? {
  toDouble() {
    return double.parse(this!);
  }
}
