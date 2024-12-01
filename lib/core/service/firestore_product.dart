import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/model/product_model.dart';

class FireStoreProduct {
  CollectionReference _productCollectionRef =
      FirebaseFirestore.instance.collection(kProductCollection);

  Future<void> addProductToFireStore(ProductModel productModel) async {
    return await _productCollectionRef
        .doc(productModel.productId)
        .set(productModel.toJson());
  }

  Future<void> updateProductInFireStore(ProductModel productModel) async {
    return await _productCollectionRef
        .doc(productModel.productId)
        .update(productModel.toJson());
  }

  Future<void> deleteProductFromFireStore(ProductModel productModel) async {
    return await _productCollectionRef.doc(productModel.productId).delete();
  }

  // Future<List<ProductModel>> loadProductData() async {
  //   var snapshot = await _productCollectionRef.get();
  //
  //   return snapshot.docs
  //       .map((doc) => ProductModel.fromJson(doc.data() as Map<String, dynamic>))
  //       .toList();
  // }

  Stream<List<QueryDocumentSnapshot>> getProductsByCategory(String category) {
    return _productCollectionRef
        .where(kProductCategory, isEqualTo: category)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }
}
