import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/core/common/widgets/custom_app_bar.dart';
import 'package:shoply/view/admin/dashboard/widgets/custom_users_item.dart';
import 'package:shoply/view_model/dashboard_viewmodel.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Users",
      ),
      body: GetBuilder<DashboardViewModel>(
          init: DashboardViewModel(),
          builder: (controller) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              itemCount: controller.userList.length,
              itemBuilder: (context, index) {
                return CustomUsersItem(
                  userPicture: controller.userList[index].picture,
                  userName: controller.userList[index].name,
                  userEmail: controller.userList[index].email,
                );
              },
            );
          }),
    );
  }
}
