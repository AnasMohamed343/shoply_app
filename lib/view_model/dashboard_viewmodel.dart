import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoply/core/service/firestore_user.dart';
import 'package:shoply/model/user_model.dart';

class DashboardViewModel extends GetxController {
  final FireStoreUser _fireStoreUser = FireStoreUser();
  ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ValueNotifier<bool> get isLoading => _isLoading;

  List<UserModel> _userList = [];
  List<UserModel> get userList => _userList;

  DashboardViewModel() {
    getAllUsers();
  }

  getAllUsers() async {
    try {
      _isLoading.value = true;
      _fireStoreUser.getAllUsers().then((value) {
        for (int i = 0; i < value.length; i++) {
          _userList
              .add(UserModel.fromJson(value[i].data() as Map<String, dynamic>));
        }
        _isLoading.value = false;
      });
      update();
    } catch (e) {
      print("Error fetching users: $e");
    }
  }
}
