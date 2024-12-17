import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/model/notification_model.dart';

class FireStoreNotification {
  CollectionReference _notificationCollectionRef =
      FirebaseFirestore.instance.collection(kNotificationCollection);

  Stream<List<QueryDocumentSnapshot>> getNotifications() {
    return _notificationCollectionRef
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  Future<void> addNotificationToFireStore(
      NotificationModel notificationModel) async {
    return await _notificationCollectionRef
        .doc(notificationModel.notificationId)
        .set(notificationModel.toJson());
  }

  Future<void> deleteNotificationFromFireStore(
      NotificationModel notificationModel) async {
    return await _notificationCollectionRef
        .doc(notificationModel.notificationId)
        .delete();
  }
}
