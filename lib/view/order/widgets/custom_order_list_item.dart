import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/view/order/widgets/custom_order_id_date_widget.dart';

class CustomOrderListItem extends StatelessWidget {
  String orderDate, orderId, shippingDate;
  CustomOrderListItem(
      {super.key,
      required this.orderDate,
      required this.orderId,
      required this.shippingDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kGreyColor.withOpacity(0.5), width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.local_shipping),
              SizedBox(
                width: 10.w,
              ),

              // 2- status & date
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Processing',
                      style: Styles.textStyle16.copyWith(
                          fontWeight: FontWeight.bold, color: kPrimaryColor),
                    ),
                    Text(
                      orderDate,
                      style: Styles.textStyle16.copyWith(fontSize: 17.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              CustomOrderIdDateWidget(
                icon: Icons.card_travel,
                title: 'Order',
                subTitle: orderId,
              ),
              const Spacer(),
              CustomOrderIdDateWidget(
                icon: Icons.local_shipping,
                title: 'Shipping Date',
                subTitle: shippingDate,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
