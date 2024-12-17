class NotificationModel {
  String? title;
  String? body;
  String? image;
  String? topic;
  String? token;
  String? notificationId;
  String? date;
  NotificationModel(
      {required this.title,
      required this.body,
      required this.notificationId,
      this.image,
      this.topic,
      this.token,
      this.date});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    image = json['image'];
    topic = json['topic'];
    token = json['token'];
    notificationId = json['notificationId'];
    date = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'image': image,
      'topic': topic,
      'token': token,
      'notificationId': notificationId,
      'dateTime': date
    };
  }
}
