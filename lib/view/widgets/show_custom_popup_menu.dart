// Show the custom popup menu
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoply/model/category_model.dart';
import 'package:shoply/view/widgets/add_category_bottom_sheet.dart';
import 'package:shoply/view_model/explore_screen_view_model.dart';
//
// void showCustomPopupMenu(BuildContext context, int index) {
//   showModalBottomSheet(
//     context: context,
//     builder: (context) {
//       return ListView(
//         shrinkWrap: true,
//         children: [
//           ListTile(
//             leading: Icon(Icons.add),
//             title: Text('Add'),
//             onTap: () {
//               Navigator.pop(context);
//               // Handle add logic
//               print('Add tapped for category index $index');
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.edit),
//             title: Text('Update'),
//             onTap: () {
//               Navigator.pop(context);
//               // Handle update logic
//               print('Update tapped for category index $index');
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.delete),
//             title: Text('Delete'),
//             onTap: () {
//               Navigator.pop(context);
//               // Handle delete logic
//               print('Delete tapped for category index $index');
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

// Show the popup menu near the category item
void showCustomPopupMenu(BuildContext context, GlobalKey itemKey, int index,
    CategoryModel category) async {
  // Get the overlay render box
  final RenderBox? overlay =
      Overlay.of(context)?.context.findRenderObject() as RenderBox?;

  if (overlay == null) {
    print("Overlay RenderBox is null");
    return;
  }

  // Get the item's render box
  final RenderBox? itemBox =
      itemKey.currentContext?.findRenderObject() as RenderBox?;

  if (itemBox == null) {
    print("Item RenderBox is null");
    return;
  }

  // Get the item's global position
  final Offset itemPosition = itemBox.localToGlobal(Offset.zero);

  // Show the menu
  final result = await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
      itemPosition.dx,
      itemPosition.dy,
      overlay.size.width - itemPosition.dx - itemBox.size.width,
      overlay.size.height - itemPosition.dy - itemBox.size.height,
    ),
    items: [
      // PopupMenuItem(
      //   value: 'add',
      //   child: ListTile(
      //     leading: Icon(Icons.add),
      //     title: Text('Add'),
      //   ),
      // ),
      PopupMenuItem(
        value: 'update',
        child: ListTile(
          leading: Icon(Icons.edit),
          title: Text('Update'),
        ),
      ),
      PopupMenuItem(
        value: 'delete',
        child: ListTile(
          leading: Icon(Icons.delete),
          title: Text('Delete'),
          //onTap: onTapDelete,
        ),
      ),
    ],
  );

  // Handle selected option
  switch (result) {
    case 'update':
      Get.find<ExploreScreenViewModel>().resetPickedImage();
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        isScrollControlled: true,
        useSafeArea: true,
        enableDrag: true,
        showDragHandle: true,
        isDismissible: true,
        context: context,
        builder: (context) => AddCategoryBottomSheet(
          widgetTitle: 'Update Category',
          buttonName: 'UPDATE',
          categoryModel: category, // Pass selected category model here
        ),
      );
      break;
    case 'delete':
      Get.find<ExploreScreenViewModel>().deleteCategory(category);
      print('Delete selected for index $index');
      break;
    default:
      print('No action selected');
  }
}
