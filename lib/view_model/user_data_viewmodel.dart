import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoply/core/assets-manager.dart';
import 'package:shoply/core/common/custom_full_screen_loader.dart';
import 'package:shoply/core/service/firestore_user.dart';
import 'package:shoply/core/service/supabase_upload_image.dart';
import 'package:shoply/model/user_model.dart';
import 'package:shoply/utils/image_functions.dart';
import 'package:shoply/view/account_tab_view/account_tab_view.dart';
import 'package:shoply/view/control_view.dart';
import 'package:shoply/view_model/auth_view_model.dart';

class UserDataViewModel extends GetxController {
  static UserDataViewModel get instance => Get.put(UserDataViewModel());
  final authController = AuthViewModel.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<User?> _user = Rx<User?>(null);

  String get user => _user.value?.email ?? '';

  UserModel? _cachedUserModel;
  Uint8List? pickedImage;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  GlobalKey<FormState> updateProfileFormKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
    if (_auth.currentUser != null) {
      authController.fetchUserData();
    }
    nameController.text = authController.userModel.name;
    emailController.text = authController.userModel.email;
  }

  // Future<void> fetchUserData() async {
  //   _cachedUserModel =
  //       await FireStoreUser().getUser(_auth.currentUser?.uid ?? '');
  // }
  //
  // UserModel get userModel {
  //   if (_cachedUserModel == null) {
  //     fetchUserData();
  //   }
  //   return _cachedUserModel ??
  //       UserModel(
  //         userId: _user.value?.uid ?? '',
  //         email: _user.value?.email ?? '',
  //         name: _user.value?.displayName ?? '',
  //         picture: _user.value?.photoURL ?? '',
  //       );
  // }

  Future<void> updateUser() async {
    try {
      //start loading
      //_loading.value = true;
      CustomFullScreenLoader.openLoadingDialog(
          '', AssetsManager.loadingAnimation);

      //check internet connectivity

      //form validation
      if (!updateProfileFormKey.currentState!.validate()) {
        //_loading.value = false;
        CustomFullScreenLoader.stopLoadingDialog();
        return;
      }

      //upload image url
      String? uploadedImageUrl;
      if (pickedImage != null) {
        uploadedImageUrl = await SupabaseUploadImage().uploadImageToStorage(
            image: pickedImage!, filePathName: 'usersProfilePictures');
      }

      //update user data
      final user = UserModel(
        userId: authController.userModel.userId,
        email: authController.userModel.email,
        name: nameController.text.trim(),
        picture: uploadedImageUrl ?? authController.userModel.picture,
      );
      await FireStoreUser().updateUser(user);

      // Fetch updated user data from Firestore
      await authController.fetchUserData();

      // stop loading
      CustomFullScreenLoader.stopLoadingDialog();

      Get.snackbar(
        'Profile updated successfully',
        'Your profile has been updated successfully',
      );

      //close dialog
      Get.to(() => ControlView());
    } catch (e) {
      Get.snackbar('Error occurred while updating profile', e.toString());
    }
  }

  Future<void> updateUserPassword() async {
    try {
      //start loading
      //_loading.value = true;
      CustomFullScreenLoader.openLoadingDialog(
          '', AssetsManager.loadingAnimation);

      //form validation
      if (!changePasswordFormKey.currentState!.validate()) {
        //_loading.value = false;
        CustomFullScreenLoader.stopLoadingDialog();
        return;
      }

      // Check if the current password is not empty
      if (currentPasswordController.text.isEmpty) {
        throw Exception('Current password cannot be empty.');
      }

      // Re-authenticate the user
      AuthCredential credential = EmailAuthProvider.credential(
        email: authController.userModel.email,
        password: currentPasswordController.text,
      );

      await _auth.currentUser?.reauthenticateWithCredential(credential);
      //update password
      if (newPasswordController.text.isNotEmpty) {
        await _auth.currentUser?.updatePassword(newPasswordController.text);
      }

      // stop loading
      CustomFullScreenLoader.stopLoadingDialog();

      Get.snackbar(
        'Password updated successfully',
        'Your password has been updated successfully',
      );

      //close dialog
      Get.to(() => ControlView());
    } catch (e) {
      Get.snackbar('Error occurred while updating password', e.toString());
    }
  }

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
}
