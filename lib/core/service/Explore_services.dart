import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoply/constants.dart';

class ExploreService {
  final CollectionReference _categoryCollectionRef =
      FirebaseFirestore.instance.collection(kCategoryCollection);

  Stream<List<QueryDocumentSnapshot>> getCategories() {
    // var data = await _categoryCollectionRef.get();
    // return data.docs;
    return _categoryCollectionRef.snapshots().map((snapshot) => snapshot.docs);
  }

  final CollectionReference _productCollectionRef =
      FirebaseFirestore.instance.collection(kProductCollection);

  // Future<List<QueryDocumentSnapshot>> getBestSellingProducts() async {
  //   var data = await _productCollectionRef.get();
  //   return data.docs;
  // }
// Use snapshots() for real-time updates
  Stream<List<QueryDocumentSnapshot>> getBestSellingProducts() {
    return _productCollectionRef.snapshots().map((snapshot) => snapshot.docs);
  }

  // Stream<List<QueryDocumentSnapshot>> fetchCategories() {
  //   return _categoryCollectionRef.snapshots().map((snapshot) => snapshot.docs);
  // }

  // Future<List<QueryDocumentSnapshot>> fetchBestSellingProducts() async {
  //   var data = await _productCollectionRef.get();
  //   return data.docs;
  // }
}
