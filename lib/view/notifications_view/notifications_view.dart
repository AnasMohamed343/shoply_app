import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoply/core/common/widgets/custom_app_bar.dart';
import 'package:shoply/view/widgets/custom_add_notification_bottomsheet.dart';
import 'package:shoply/view/widgets/custom_button.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Notifications'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                CustomButton(
                    buttonText: 'Add Notification',
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
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
