import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/model/user_model.dart';

class FireStoreUser {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection(kUserCollection);
  Future<void> addUserToFireStore(UserModel userModel) async {
    try {
      return await _userCollectionRef
          .doc(userModel.userId)
          .set(userModel.toJson());
    } catch (e) {
      throw 'Error while adding user: $e';
    }
  }

  Future<void> updateUser(UserModel userModel) async {
    try {
      return await _userCollectionRef
          .doc(userModel.userId)
          .update(userModel.toJson());
    } catch (e) {
      throw 'Error while updating user: $e';
    }
  }

  //
  // Future<void> deleteUser(String userId) async {
  //   return await _userCollectionRef.doc(userId).delete();
  // }

  // CollectionReference<UserModel> getUserCollection() {
  //   try {
  //     return _userCollectionRef.withConverter<UserModel>(
  //         fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
  //         toFirestore: (userModel, _) => userModel.toJson());
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  Future<UserModel?> getUser(String userId) async {
    // var userCollection = getUserCollection();
    // var doc = userCollection.doc(userId);
    // var docSnapshot = await doc.get();
    // return docSnapshot.data();
    try {
      DocumentSnapshot documentSnapshot =
          await _userCollectionRef.doc(userId).get();
      return UserModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print("Error getting user: $e");
      return null;
    }
  }

  Future<List<QueryDocumentSnapshot>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await _userCollectionRef.get();
      return querySnapshot.docs;
    } catch (e) {
      throw 'Error while fetching users: $e';
    }
  }
}
