class UserModel {
  String userId, email, name, picture;

  UserModel(
      {required this.userId,
      required this.email,
      required this.name,
      required this.picture});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      email: json['email'],
      name: json['name'],
      picture: json['picture'],
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'email': email,
        'name': name,
        'picture': picture,
      };
}
