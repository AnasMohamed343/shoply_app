import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/main.dart';
import 'package:shoply/view/Cart_tab_view/cart_tab_view.dart';
import 'package:shoply/view/address/address_screen.dart';
import 'package:shoply/view/admin/dashboard/dashboard_screen_view.dart';
import 'package:shoply/view/map_screen/map_screen.dart';
import 'package:shoply/view/notifications_view/notifications_view.dart';
import 'package:shoply/view/order/order_screen.dart';
import 'package:shoply/view_model/auth_view_model.dart';

class AccountTabView extends StatelessWidget {
  AccountTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: h * 0.025,
            vertical: h * 0.015,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Static user profile details
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                    vertical: h * 0.03,
                  ),
                  child: GetBuilder<AuthViewModel>(
                      init: AuthViewModel(),
                      builder: (controller) {
                        final user = controller.userModel;

                        return user == null
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ))
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: w * 0.01),
                                  Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: w * 0.15,
                                        backgroundColor: Colors.grey.shade200,
                                        backgroundImage: NetworkImage(
                                          "https://via.placeholder.com/150", // Replace with static/default image URL
                                        ),
                                        child: null,
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: w * 0.05),
                                  Column(
                                    children: [
                                      Text(
                                        user.name, // Replace with default static name
                                        style: Styles.textStyle18,
                                      ),
                                      SizedBox(height: h * 0.005),
                                      Text(
                                        user.email, // Replace with default static email
                                        style: Styles.textStyle16
                                            .copyWith(color: kGreyColor),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                      }),
                ),
                SizedBox(height: h * 0.05),
                _buildOptionRow(
                  context,
                  title: 'Edit Your Profile',
                  icon: Icons.edit,
                  onTap: () {},
                ),
                _buildDivider(),
                _buildOptionRow(
                  context,
                  icon: Icons.location_on,
                  title: 'Address',
                  onTap: () {
                    //Get.to(MapScreen());
                    Get.to(AddressScreen());
                  },
                ),
                _buildDivider(),
                _buildOptionRow(
                  context,
                  icon: Icons.receipt, // Replace with your asset
                  title: 'Orders',
                  onTap: () {
                    Get.to(OrderScreen());
                  },
                ),
                _buildDivider(),
                _buildOptionRow(
                  context,
                  icon: Icons.payment,
                  title: 'Notifications',
                  onTap: () {
                    Get.to(
                      NotificationsView(),
                    );
                  },
                ),
                _buildDivider(),
                _buildOptionRow(
                  context,
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  onTap: () {
                    Get.to(DashboardScreenView());
                  },
                ),
                _buildDivider(),
                GetBuilder<AuthViewModel>(
                    init: AuthViewModel(),
                    builder: (controller) {
                      return GestureDetector(
                        onTap: () => controller.signOut(),
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout_sharp,
                              color:
                                  kPrimaryColor, // Replace with kPrimaryColor
                              size: w * 0.05,
                            ),
                            SizedBox(width: w * 0.03),
                            Text('Log Out', style: Styles.textStyle16),
                            const Spacer(),
                            Icon(Icons.arrow_forward_ios,
                                color: kPrimaryColor, size: w * 0.05),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionRow(BuildContext context,
      {IconData? icon,
      String? asset,
      required String title,
      required VoidCallback onTap}) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          if (icon != null)
            Icon(icon,
                color: kPrimaryColor,
                size: w * 0.05) // Replace with kPrimaryColor
          else if (asset != null)
            SvgPicture.asset(
              asset,
              color: kPrimaryColor, // Replace with kPrimaryColor
              height: h * 0.03,
              width: w * 0.03,
            ),
          SizedBox(width: w * 0.03),
          Text(title, style: Styles.textStyle16),
          const Spacer(),
          Icon(Icons.arrow_forward_ios,
              color: kPrimaryColor,
              size: w * 0.05), // Replace with kPrimaryColor
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15).r,
      child: Divider(
        color: Colors.grey.shade200,
        thickness: 1.5,
        indent: 5,
        endIndent: 5,
      ),
    );
  }
}
