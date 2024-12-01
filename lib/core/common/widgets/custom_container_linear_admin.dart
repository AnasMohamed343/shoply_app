import 'package:flutter/material.dart';
import 'package:shoply/constants.dart';

class CustomContainerLinearAdmin extends StatelessWidget {
  final double width, height;
  final Widget child;
  CustomContainerLinearAdmin(
      {super.key,
      required this.width,
      required this.height,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            kPrimaryColor.withOpacity(0.9),
            Colors.green.withOpacity(0.2),
          ],
          begin: const Alignment(0.36, 0.27),
          end: const Alignment(0.58, 0.85),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4), // changes position of shadow
          ),
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.3),
            blurRadius: 2,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }
}
