import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/core/common/widgets/custom_app_bar.dart';
import 'package:shoply/core/common/widgets/custom_build_option_row.dart';
import 'package:shoply/core/common/widgets/custom_divider.dart';
import 'package:shoply/view/settings/change_password/change_password_screen.dart';
import 'package:shoply/view/settings/edit_profile/edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Settings'),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            buildOptionRow(
              context,
              title: 'Edit Profile',
              icon: Icons.edit,
              onTap: () {
                Get.to(const EditProfileScreen());
              },
            ),
            const CustomDivider(),
            buildOptionRow(
              context,
              icon: Icons.lock,
              title: 'Change Password',
              onTap: () {
                //Get.to(MapScreen());
                Get.to(const ChangePasswordScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
