import 'package:flutter/material.dart';
import 'package:shoply/model/user_model.dart';

class CustomProfilePicture extends StatelessWidget {
  const CustomProfilePicture({
    super.key,
    required this.w,
    required this.user,
  });

  final double w;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: w,
      backgroundColor: Colors.grey.shade200,
      backgroundImage: user.picture != null || user.picture != ''
          ? NetworkImage(
              user.picture,
            )
          : null,
      //child: null,
    );
  }
}
