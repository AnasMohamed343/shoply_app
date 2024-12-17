import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/view/widgets/custom_notification_item.dart';
import 'package:shoply/view_model/notification_viewmodel.dart';

// class CustomNotificationList extends StatelessWidget {
//   const CustomNotificationList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     double h = MediaQuery.of(context).size.height;
//     double w = MediaQuery.of(context).size.width;
//     return GetBuilder<NotificationViewModel>(
//         init: NotificationViewModel(),
//         builder: (controller) {
//           return controller.isLoading.value == true
//               ? const Center(
//                   child: CircularProgressIndicator(
//                     color: kPrimaryColor,
//                   ),
//                 )
//               : ListView.separated(
//                   separatorBuilder: (context, index) {
//                     return Container(
//                       height: h * 0.001,
//                       width: w,
//                       color: kGreyColor.withOpacity(0.3),
//                     );
//                   },
//                   itemCount: controller.notifications.length,
//                   itemBuilder: (context, index) {
//                     return Slidable(
//                       endActionPane: ActionPane(
//                         extentRatio: .3.sp,
//                         motion: const ScrollMotion(),
//                         children: [
//                           SlidableAction(
//                             onPressed: (context) {
//                               controller.deleteNotification(
//                                   controller.notifications[index]);
//                             },
//                             backgroundColor: Colors.red,
//                             foregroundColor: Colors.white,
//                             icon: Icons.delete,
//                             label: 'Delete',
//                           ),
//                         ],
//                       ),
//                       child: CustomNotificationItem(
//                         title: controller.notifications[index].title ?? '',
//                         body: controller.notifications[index].body ?? '',
//                         date: controller.notifications[index].date ?? '',
//                         image: controller.notifications[index].image ?? '',
//                       ),
//                     );
//                   },
//                 );
//         });
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/view/widgets/custom_notification_item.dart';
import 'package:shoply/view_model/notification_viewmodel.dart';

class CustomNotificationList extends StatelessWidget {
  const CustomNotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationViewModel>(
      builder: (controller) {
        if (controller.isLoading.value == true) {
          return const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        }
        if (controller.notifications.isEmpty) {
          return const Center(
            child: Text('No notifications found.'),
          );
        }
        return ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: kGreyColor.withOpacity(0.3),
          ),
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return Slidable(
              endActionPane: ActionPane(
                extentRatio: 0.3,
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      controller.deleteNotification(notification);
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: CustomNotificationItem(
                title: notification.title ?? '',
                body: notification.body ?? '',
                date: notification.date ?? '',
                image: notification.image ?? '',
              ),
            );
          },
        );
      },
    );
  }
}
