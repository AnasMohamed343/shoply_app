class NotificationModel {
  String title;
  String body;
  String? image;
  String? topic;
  String? token;
  NotificationModel(
      {required this.title,
      required this.body,
      this.image,
      this.topic,
      this.token});
}
