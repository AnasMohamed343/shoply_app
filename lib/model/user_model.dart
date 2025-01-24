import 'package:shoply/utils/enum.dart';

class UserModel {
  String userId, email, name, picture;
  AppRole role;

  UserModel(
      {required this.userId,
      required this.email,
      required this.name,
      required this.picture,
      this.role = AppRole.user});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userId: json['userId'],
        email: json['email'],
        name: json['name'],
        picture: json['picture'],
        role: json.containsKey('role')
            ? (json['role'] ?? AppRole.user) == AppRole.admin.name.toString()
                ? AppRole.admin
                : AppRole.user
            : AppRole.user);
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'email': email,
        'name': name,
        'picture': picture,
        'role': role.name.toString(),
      };
}
