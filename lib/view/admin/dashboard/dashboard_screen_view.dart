import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/core/assets-manager.dart';
import 'package:shoply/view/admin/dashboard/users_list/users_list.dart';
import 'package:shoply/view/admin/dashboard/widgets/dashboard_item.dart';
import 'package:shoply/view_model/dashboard_viewmodel.dart';
import 'package:shoply/view_model/explore_screen_view_model.dart';

class DashboardScreenView extends StatelessWidget {
  const DashboardScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: Styles.textStyle24,
        ),
      ),
      body: GetBuilder<ExploreScreenViewModel>(
          init: ExploreScreenViewModel(),
          builder: (controller) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 2));
                  await Get.find<DashboardViewModel>().refreshUsers();
                  await controller.refreshProductsAndCategories();
                },
                child: ListView(
                  //i used listview here because i want to make refresh indicator
                  children: [
                    DashboardItem(
                        title: "Categries",
                        number: controller.categoryList.length.toString(),
                        image: AssetsManager.gadgetsCategory),
                    SizedBox(
                      height: 20.h,
                    ),
                    DashboardItem(
                        title: "Products",
                        number: controller.productList.length.toString(),
                        image: AssetsManager.gamingCategory),
                    SizedBox(
                      height: 20.h,
                    ),
                    GetBuilder<DashboardViewModel>(
                        init: DashboardViewModel(),
                        builder: (controller) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(UsersList());
                            },
                            child: DashboardItem(
                                title: "Total Users",
                                number: controller.userList.length.toString(),
                                image: AssetsManager.accountTabIcon),
                          );
                        }),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
