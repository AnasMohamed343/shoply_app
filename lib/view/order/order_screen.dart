import 'package:flutter/material.dart';
import 'package:shoply/core/common/widgets/custom_app_bar.dart';
import 'package:shoply/view/order/widgets/order_list_items.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'My Orders'),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: OrderListItems(),
      ),
    );
  }
}
