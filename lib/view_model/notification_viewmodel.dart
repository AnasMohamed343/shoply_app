import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoply/core/service/firestore_notification.dart';
import 'package:shoply/core/service/push_notifications/fcm_api_manager.dart';
import 'package:shoply/model/notification_model.dart';
import 'package:shoply/utils/image_functions.dart';

// class NotificationViewModel extends GetxController {
//   ValueNotifier<bool> _isLoading = ValueNotifier(false);
//   ValueNotifier<bool> get isLoading => _isLoading;
//
//   String? title, body;
//   Uint8List? pickedImage;
//
//   List<NotificationModel> _notifications = [];
//   List<NotificationModel> get notifications => _notifications;
//
//   NotificationViewModel() {
//     getNotifications();
//   }
//
//   sendNotification(NotificationModel notificationModel) async {
//     try {
//       _isLoading.value = true;
//       //update();
//       await FcmApiManager().sendNotification(notificationModel);
//       _isLoading.value = false;
//       Get.snackbar(
//         'Success',
//         'Notification sent successfully',
//         snackPosition: SnackPosition.TOP,
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );
//     } catch (e) {
//       _isLoading.value = false;
//       print('Error sending notification: $e');
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         snackPosition: SnackPosition.TOP,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//     update();
//   }
//
//   pickImage(String pickType) async {
//     Uint8List? temp;
//     if (pickType == 'gallery') {
//       temp = await ImageFunctions.galleryPicker();
//     } else if (pickType == 'camera') {
//       temp = await ImageFunctions.cameraPicker();
//     }
//     if (temp != null) {
//       pickedImage = temp;
//       update();
//     }
//   }
//
//   getNotifications() async {
//     _isLoading.value = true;
//     FireStoreNotification().getNotifications().listen((notificationDocs) {
//       _notifications.clear();
//       _notifications.addAll(notificationDocs.map((doc) =>
//           NotificationModel.fromJson(doc.data() as Map<String, dynamic>)));
//     });
//     _isLoading.value = false;
//     update();
//   }
//
//   addNotification(NotificationModel notificationModel) async {
//     try {
//       _isLoading.value = true;
//       await FireStoreNotification()
//           .addNotificationToFireStore(notificationModel);
//     } catch (e) {
//       _isLoading.value = false;
//       print(e.toString());
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         snackPosition: SnackPosition.TOP,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//     update();
//   }
//
//   deleteNotification(NotificationModel notificationModel) async {
//     try {
//       _isLoading.value = true;
//       await FireStoreNotification()
//           .deleteNotificationFromFireStore(notificationModel);
//       update();
//     } catch (e) {
//       _isLoading.value = false;
//       print(e.toString());
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         snackPosition: SnackPosition.TOP,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//     update();
//   }
// }

class NotificationViewModel extends GetxController {
  ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ValueNotifier<bool> get isLoading => _isLoading;

  // Notifications list
  List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => _notifications;

  String? title, body;
  Uint8List? pickedImage;

  // Constructor to initialize notifications
  NotificationViewModel() {
    getNotifications();
  }

  // Send a notification
  Future<void> sendNotification(NotificationModel notificationModel) async {
    try {
      _isLoading.value = true;
      update(); // Notify listeners about loading state
      await FcmApiManager().sendNotification(notificationModel);
      Get.snackbar(
        'Success',
        'Notification sent successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
      update(); // Notify listeners about the updated state
    }
  }

  // Pick an image for the notification
  Future<void> pickImage(String pickType) async {
    Uint8List? temp;
    if (pickType == 'gallery') {
      temp = await ImageFunctions.galleryPicker();
    } else if (pickType == 'camera') {
      temp = await ImageFunctions.cameraPicker();
    }
    if (temp != null) {
      pickedImage = temp;
      update(); // Notify listeners about the image selection
    }
  }

  // Fetch notifications from Firestore
  void getNotifications() {
    _isLoading.value = true;
    update(); // Notify listeners about loading state

    FireStoreNotification().getNotifications().listen((notificationDocs) {
      _notifications = notificationDocs
          .map((doc) =>
              NotificationModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      _isLoading.value = false;
      update(); // Notify listeners about the updated notifications list
    });
  }

  // Add a notification to Firestore
  Future<void> addNotification(NotificationModel notificationModel) async {
    try {
      _isLoading.value = true;
      update(); // Notify listeners about loading state
      await FireStoreNotification()
          .addNotificationToFireStore(notificationModel);
      Get.snackbar(
        'Success',
        'Notification added successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
      update(); // Notify listeners about the updated state
    }
  }

  // Delete a notification from Firestore
  Future<void> deleteNotification(NotificationModel notificationModel) async {
    try {
      _isLoading.value = true;
      update(); // Notify listeners about loading state
      await FireStoreNotification()
          .deleteNotificationFromFireStore(notificationModel);
      _notifications.remove(notificationModel);
      // Get.snackbar(
      //   'Success',
      //   'Notification deleted successfully',
      //   snackPosition: SnackPosition.TOP,
      //   backgroundColor: Colors.green,
      //   colorText: Colors.white,
      // );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
      update(); // Notify listeners about the updated list
    }
  }
}
