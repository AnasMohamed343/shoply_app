import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoply/core/service/Explore_services.dart';
import 'package:shoply/core/service/firestore_category.dart';
import 'package:shoply/core/service/firestore_product.dart';
import 'package:shoply/model/category_model.dart';
import 'package:shoply/model/product_model.dart';
import 'package:shoply/utils/image_functions.dart';

class ExploreScreenViewModel extends GetxController {
  ValueNotifier<bool> _isLoading = ValueNotifier(false);

  ValueNotifier<bool> get isLoading => _isLoading;

  List<CategoryModel> _categoryList = [];

  List<CategoryModel> get categoryList => _categoryList;

  List<ProductModel> _productList = [];
  List<ProductModel> _productListByCategory = [];

  List<ProductModel> get productList => _productList;
  List<ProductModel> get productListByCategory => _productListByCategory;

  String? name, description, price, size, productCategory;

  String? categoryName;

  Color? color;

  Uint8List? pickedImage;

  // bool _httpRequestFailed = false;
  // bool get httpRequestFailed => _httpRequestFailed;
  // set httpRequestFailed(bool value) => _httpRequestFailed = value;
  final _httpRequestFailed = ValueNotifier<bool>(false);
  ValueNotifier<bool> get httpRequestFailed => _httpRequestFailed;

  // @override
  // void onInit() {
  //   super.onInit();
  // }
  //
  // @override
  // void onReady() {
  //   super.onReady();
  // }

  ExploreScreenViewModel() {
    getCategory();
    getBestSellingProducts();
  }

  String? _selectedCategoryName;

  String? get selectedCategoryName => _selectedCategoryName;

  set selectedCategoryName(String? value) {
    _selectedCategoryName = value;
    update();
  }

  Color? _pickerColor;

  Color? get pickerColor => _pickerColor;

  void changeColor(Color color) {
    _pickerColor = color;
    update();
  }

  getCategory() async {
    _isLoading.value = true;
    ExploreService().getCategories().listen((value) {
      _categoryList.clear();
      for (int i = 0; i < value.length; i++) {
        _categoryList.add(
            CategoryModel.fromJson(value[i].data() as Map<String, dynamic>));
        //print(_categoryList.length);
        _isLoading.value = false;
      }
      update();
    });
  }

  addCategory(CategoryModel category) async {
    _isLoading.value = true;
    try {
      await FireStoreCategory().addCategoryToFireStore(category);
      _isLoading.value = false;
      Get.snackbar(
        'Success',
        'Category added successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      update();
    } catch (e) {
      _isLoading.value = false;
      print('category error : ${e.toString()}');
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      update();
    }
  }

  updateCategory(CategoryModel category) async {
    _isLoading.value = true;
    try {
      await FireStoreCategory().updateCategoryInFireStore(category);
      _isLoading.value = false;
      Get.snackbar(
        'Success',
        'Category updated successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      update();
    } catch (e) {
      _isLoading.value = false;
      print(e.toString());
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      update();
    }
  }

  deleteCategory(CategoryModel category) async {
    _isLoading.value = true;
    try {
      await FireStoreCategory().deleteCategoryFromFireStore(category);
      _isLoading.value = false;
      Get.snackbar(
        'Success',
        'Category deleted successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      update();
    } catch (e) {
      _isLoading.value = false;
      print(e.toString());
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      update();
    }
  }

  // void fetchCategory() async {
  //   _isLoading.value = true;
  //   try {
  //     var categoryDocs = await ExploreService().fetchCategories();
  //     _categoryList.clear();
  //     _categoryList.addAll(
  //       categoryDocs.map(
  //           (doc) => CategoryModel.fromJson(doc.data() as Map<String, dynamic>)),
  //     );
  //     _isLoading.value = false;
  //     update();
  //   } catch (e) {
  //     _isLoading.value = false;
  //     update();
  //   }
  // }
  void getProductsByCategory(String category) async {
    _isLoading.value = true;
    FireStoreProduct().getProductsByCategory(category).listen((value) {
      _productListByCategory.clear();
      _productListByCategory.addAll(
        value.map(
            (doc) => ProductModel.fromJson(doc.data() as Map<String, dynamic>)),
      );
      _isLoading.value = false;
      update();
    });
  }

  // getBestSellingProducts() async {
  //   _isLoading.value = true;
  //   ExploreService().getBestSellingProducts().then((value) {
  //     for (int i = 0; i < value.length; i++) {
  //       _productList.add(
  //           ProductModel.fromJson(value[i].data() as Map<String, dynamic>));
  //       print(_productList.length);
  //       _isLoading.value = false;
  //     }
  //     update();
  //   });
  // }
  void getBestSellingProducts() {
    _isLoading.value = true;
    ExploreService().getBestSellingProducts().listen((productDocs) {
      _productList.clear();
      _productList.addAll(
        productDocs.map(
            (doc) => ProductModel.fromJson(doc.data() as Map<String, dynamic>)),
      );
      _isLoading.value = false;
      update();
    });
  }
  //
  // void fetchBestSellingProducts() async {
  //   _isLoading.value = true;
  //   try {
  //     var productDocs = await ExploreService().fetchBestSellingProducts();
  //     _productList.clear();
  //     _productList.addAll(
  //       productDocs.map(
  //           (doc) => ProductModel.fromJson(doc.data() as Map<String, dynamic>)),
  //     );
  //     _isLoading.value = false;
  //   } catch (e) {
  //     _isLoading.value = false;
  //     print("Error fetching products: $e");
  //   }
  //   update();
  // }

  // addNewProduct(ProductModel productModel) async {
  //   try {
  //     _isLoading.value = true;
  //     await FireStoreProduct().addProductToFireStore(productModel);
  //     _isLoading.value = false;
  //     Get.snackbar(
  //       'Success',
  //       'Product added successfully',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //     fetchBestSellingProducts(); // Fetch products again after adding a new one
  //   } catch (e) {
  //     _isLoading.value = false;
  //     print(e.toString());
  //     Get.snackbar(
  //       'Error',
  //       e.toString(),
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }

  // addNewProduct(ProductModel product) async {
  //   _isLoading.value = true;
  //   await FireStoreProduct().addProductToFireStore(product);
  //   _isLoading.value = false;
  //   update();
  // }
  addNewProduct(ProductModel productModel) async {
    try {
      _isLoading.value = true;
      update();
      await FireStoreProduct().addProductToFireStore(productModel);
      //_productList.add(productModel);
      _isLoading.value = false;
      Get.snackbar(
        'Success',
        'Product added successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      _isLoading.value = false;
      update();
      print(e.toString());
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    update();
  }

  updateProduct(ProductModel productModel) async {
    try {
      _isLoading.value = true;
      update();
      await FireStoreProduct().updateProductInFireStore(productModel);
      _isLoading.value = false;
      update();
      Get.snackbar(
        'Success',
        'Product updated successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      _isLoading.value = false;
      print(e.toString());
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    update();
  }

  removeProduct(ProductModel productModel) async {
    _isLoading.value = true;
    await FireStoreProduct().deleteProductFromFireStore(productModel);
    _isLoading.value = false;
    update();
  }

  // loadProductData() async {
  //   _isLoading.value = true;
  //   _productList.clear();
  //   _productList.addAll(await FireStoreProduct().loadProductData());
  //   _isLoading.value = false;
  //   update();
  // }

  pickImage(String pickType) async {
    Uint8List? temp;
    if (pickType == 'gallery') {
      temp = await ImageFunctions.galleryPicker();
    } else if (pickType == 'camera') {
      temp = await ImageFunctions.cameraPicker();
    }
    if (temp != null) {
      pickedImage = temp;
      update();
    }
  }

  void resetPickedImage() {
    pickedImage = null; // Reset picked image
    _pickerColor = Colors.white;
    update(); // Update UI to show the correct initial state
  }
}
