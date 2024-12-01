import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/model/user_model.dart';

class FireStoreUser {
  CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection(kUserCollection);
  Future<void> addUserToFireStore(UserModel userModel) async {
    return await _userCollectionRef
        .doc(userModel.userId)
        .set(userModel.toJson());
  }

  CollectionReference<UserModel> getUserCollection() {
    try {
      return _userCollectionRef.withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (userModel, _) => userModel.toJson());
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel?> getUser(String userId) async {
    var userCollection = getUserCollection();
    var doc = userCollection.doc(userId);
    var docSnapshot = await doc.get();
    return docSnapshot.data();
  }

  Future<List<QueryDocumentSnapshot>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await _userCollectionRef.get();
      return querySnapshot.docs;
    } catch (e) {
      print("Error getting users: $e");
      return [];
    }
  }
}
