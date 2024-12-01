// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // import 'package:shoply/core/Styles.dart';
// // import 'package:shoply/core/assets-manager.dart';
// // import 'package:shoply/view/Cart_tab_view/cart_tab_view.dart';
// // import 'package:shoply/view/Explore_tab_view/explore_tab_view.dart';
// // import 'package:shoply/view/account_tab_view/account_tab_view.dart';
// // import 'package:shoply/view/widgets/category_list.dart';
// // import 'package:shoply/view/widgets/custom_category_item.dart';
// // import 'package:shoply/view/widgets/custom_search_text_field.dart';
// //
// // import 'widgets/custom_product_item.dart';
// //
// // class HomeScreen extends StatefulWidget {
// //   HomeScreen({super.key});
// //
// //   @override
// //   State<HomeScreen> createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> {
// //   List<Widget> tabList = [
// //     ExploreTabView(),
// //     CartTabView(),
// //     AccountTabView(),
// //   ];
// //
// //   int selectedIndex = 0;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         elevation: 0.0,
// //         backgroundColor: Colors.white,
// //       ),
// //       body: tabList[selectedIndex],
// //       bottomNavigationBar: BottomNavigationBar(
// //         backgroundColor: Colors.white,
// //         currentIndex: selectedIndex,
// //         showSelectedLabels: true,
// //         showUnselectedLabels: false,
// //         selectedLabelStyle: Styles.textStyle14.copyWith(color: Colors.black),
// //         selectedItemColor: Colors.black,
// //         onTap: (index) {
// //           setState(() {
// //             selectedIndex = index;
// //           });
// //         },
// //         items: [
// //           BottomNavigationBarItem(
// //             icon: selectedIndex == 0
// //                 ? const SizedBox.shrink()
// //                 : SvgPicture.asset(
// //                     AssetsManager.exploreTabIcon,
// //                     height: 18.h,
// //                     width: 18.w,
// //                   ),
// //             label: 'Explore \n      .',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: selectedIndex == 1
// //                 ? const SizedBox.shrink()
// //                 : SvgPicture.asset(
// //                     AssetsManager.cartTabIcon,
// //                     height: 18.h,
// //                     width: 18.w,
// //                   ),
// //             label: 'Cart \n    .',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: selectedIndex == 2
// //                 ? const SizedBox.shrink()
// //                 : SvgPicture.asset(
// //                     AssetsManager.accountTabIcon,
// //                     height: 18.h,
// //                     width: 18.w,
// //                   ),
// //             label: 'Account \n      .',
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// /////// by using getx /////////
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:shoply/core/Styles.dart';
// import 'package:shoply/core/assets-manager.dart';
// import 'package:shoply/view/Cart_tab_view/cart_tab_view.dart';
// import 'package:shoply/view/Explore_tab_view/explore_tab_view.dart';
// import 'package:shoply/view/account_tab_view/account_tab_view.dart';
// import 'package:shoply/view/widgets/category_list.dart';
// import 'package:shoply/view/widgets/custom_category_item.dart';
// import 'package:shoply/view/widgets/custom_search_text_field.dart';
// import 'package:shoply/view_model/control_view_model.dart';
//
// import 'widgets/custom_product_item.dart';
//
// class HomeScreen extends StatefulWidget {
//   HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<Widget> tabList = [
//     ExploreTabView(),
//     CartTabView(),
//     AccountTabView(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Colors.white,
//       ),
//       body: tabList[Get.find<HomeViewModel>().navigatorIndex],
//     );
//   }
// }
