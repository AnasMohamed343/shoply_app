import 'package:flutter/material.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';

class CustomSectionHeading extends StatelessWidget {
  String title;
  String? buttonTitle;
  Function()? onPressed;

  CustomSectionHeading({
    super.key,
    required this.title,
    this.buttonTitle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Styles.textStyle18.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonTitle ?? '',
            style: Styles.textStyle16.copyWith(
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
