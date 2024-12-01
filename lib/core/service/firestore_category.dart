import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/model/category_model.dart';

class FireStoreCategory {
  final CollectionReference _categoryCollectionRef =
      FirebaseFirestore.instance.collection(kCategoryCollection);

  Future<void> addCategoryToFireStore(CategoryModel categoryModel) async {
    return await _categoryCollectionRef
        .doc(categoryModel.categoryId)
        .set(categoryModel.toJson());
  }

  Future<void> updateCategoryInFireStore(CategoryModel categoryModel) async {
    return await _categoryCollectionRef
        .doc(categoryModel.categoryId)
        .update(categoryModel.toJson());
  }

  Future<void> deleteCategoryFromFireStore(CategoryModel categoryModel) async {
    return await _categoryCollectionRef.doc(categoryModel.categoryId).delete();
  }
}
