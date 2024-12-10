import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoply/core/service/push_notifications/fcm_api_manager.dart';
import 'package:shoply/model/notification_model.dart';
import 'package:shoply/utils/image_functions.dart';

class NotificationViewModel extends GetxController {
  ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ValueNotifier<bool> get isLoading => _isLoading;

  String? title, body;
  Uint8List? pickedImage;

  sendNotification(NotificationModel notificationModel) async {
    try {
      _isLoading.value = true;
      //update();
      await FcmApiManager().sendNotification(notificationModel);
      _isLoading.value = false;
      Get.snackbar(
        'Success',
        'Notification sent successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      _isLoading.value = false;
      print('Error sending notification: $e');
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
