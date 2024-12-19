import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/model/address_model.dart';
import 'package:shoply/view_model/auth_view_model.dart';

class FireStoreAddress {
  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      final userId = AuthViewModel.instance.authUser!.uid;
      if (userId.isEmpty)
        throw 'unable to find user information. Please try again later';
      final result = await _db
          .collection(kUserCollection)
          .doc(userId)
          .collection(kUserAddresses)
          .get();
      //return result.docs.map((e) => AddressModel.fromJson(e.data())).toList();
      return result.docs
          .map((documentSnapshot) =>
              AddressModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'something went wrong while fetching user addresses, try again later';
    }
  }

  //Clear the "selected" field of all addresses
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = AuthViewModel.instance.authUser!.uid;
      await _db
          .collection(kUserCollection)
          .doc(userId)
          .collection(kUserAddresses)
          .doc(addressId)
          .update({'selectedAddress': selected});
    } catch (e) {
      throw 'unable to update your address selection, try again later';
    }
  }

  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthViewModel.instance.authUser!.uid;
      final currentAddress = await _db
          .collection(kUserCollection)
          .doc(userId)
          .collection(kUserAddresses)
          .add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw 'something went wrong while saving address information, try again later';
    }
  }
}
