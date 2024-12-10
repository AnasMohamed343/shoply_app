// import 'package:dio/dio.dart';
//
// class FcmApiManager {
//   final String serverKey =
//       'AIzaSyATOE_xJpGFAPI5RrOlOX0mHsTaaLuGuS0'; // Replace with your FCM server key.
//   final String endpoint =
//       'https://fcm.googleapis.com/v1/projects/shoply-e-commerce/messages:send';
//
//   Future<void> sendNotification({
//     String? token, // If sending to a specific device
//     String? topic, // If sending to a topic
//     required String title,
//     required String body,
//     String? imageUrl, // Optional image URL for the notification
//   }) async {
//     try {
//       final Dio dio = Dio();
//       dio.options.headers['Authorization'] = 'Bearer $serverKey';
//       dio.options.headers['Content-Type'] = 'application/json';
//
//       final notification = {
//         'message': {
//           if (token != null) 'token': token,
//           if (topic != null) 'topic': topic,
//           'notification': {
//             'title': title,
//             'body': body,
//             if (imageUrl != null) 'image': imageUrl,
//           },
//           'android': {
//             'notification': {
//               'sound': 'long_notification_sound',
//               'channel_id': 'channel_id',
//             }
//           },
//         }
//       };
//
//       final response = await dio.post(endpoint, data: notification);
//
//       if (response.statusCode == 200) {
//         print('Notification sent successfully: ${response.data}');
//       } else {
//         print('Failed to send notification: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error sending notification: $e');
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:shoply/core/service/push_notifications/fcm_auth_service.dart';
import 'package:shoply/model/notification_model.dart';

class FcmApiManager {
  final String endpoint =
      'https://fcm.googleapis.com/v1/projects/shoply-e-commerce/messages:send';

  Future<void> sendNotification(NotificationModel notificationModel) async {
    //final FCMAuthService authService = FCMAuthService();
    final accessToken = await FCMAuthService.getAccessToken();

    if (accessToken == null) {
      print('Failed to retrieve access token. Cannot send notification.');
      return;
    }

    try {
      final Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $accessToken';
      dio.options.headers['Content-Type'] = 'application/json';

      final notification = {
        'message': {
          if (notificationModel.token != null) 'token': notificationModel.token,
          if (notificationModel.topic != null) 'topic': notificationModel.topic,
          'notification': {
            'title': notificationModel.title,
            'body': notificationModel.body,
            if (notificationModel.image != null)
              'image': notificationModel.image,
          },
          'android': {
            'notification': {
              'sound': 'long_notification_sound',
              'channel_id': 'channel_id',
            }
          },
        }
      };

      final response = await dio.post(endpoint, data: notification);

      if (response.statusCode == 200) {
        print('Notification sent successfully: ${response.data}');
      } else {
        print('Failed to send notification: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }
}
