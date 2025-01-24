import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/core/common/widgets/custom_app_bar.dart';
import 'package:shoply/utils/enum.dart';
import 'package:shoply/view/notifications_view/custom_notification_list.dart';
import 'package:shoply/view/widgets/custom_add_notification_bottomsheet.dart';
import 'package:shoply/view/widgets/custom_button.dart';
import 'package:shoply/view_model/auth_view_model.dart';
import 'package:shoply/view_model/notification_viewmodel.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Notifications'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                GetBuilder<AuthViewModel>(
                    init: AuthViewModel(),
                    builder: (controller) {
                      return controller.userModel.role == AppRole.admin
                          ? CustomButton(
                              buttonText: Text('Send Notification',
                                  style: Styles.textStyle14),
                              onPressed: () {
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.r),
                                        topRight: Radius.circular(20.r),
                                      ),
                                    ),
                                    isScrollControlled: true,
                                    useSafeArea: true,
                                    enableDrag: true,
                                    showDragHandle: true,
                                    isDismissible: true,
                                    context: context,
                                    builder: (context) {
                                      return CustomAddNotificationBottomSheet();
                                    });
                              })
                          : const SizedBox.shrink();
                    }),
              ],
            ),
            GetBuilder<NotificationViewModel>(
                init: NotificationViewModel(),
                builder: (context) {
                  return const Expanded(child: CustomNotificationList());
                }),
          ],
        ),
      ),
    );
  }
}
