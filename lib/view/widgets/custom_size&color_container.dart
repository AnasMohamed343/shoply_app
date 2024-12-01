import 'package:flutter/material.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';

class CustomSizeColorContainer extends StatelessWidget {
  String containerName;
  Widget containerType;
  CustomSizeColorContainer(
      {super.key, required this.containerName, required this.containerType});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 0.06,
      width: w * 0.43,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kGreyColor.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            containerName,
            style: Styles.textStyle14,
          ),
          containerType,
        ],
      ),
    );
  }
}
