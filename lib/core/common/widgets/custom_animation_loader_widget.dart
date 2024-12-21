import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/view/widgets/custom_button.dart';

class CustomAnimationLoaderWidget extends StatelessWidget {
  final String animationPath;
  final String? text;
  final bool showAction;
  final VoidCallback? onActionPressed;
  final String? actionText;
  CustomAnimationLoaderWidget(
      {super.key,
      required this.animationPath,
      this.text,
      this.showAction = false,
      this.onActionPressed,
      this.actionText});

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animationPath, width: w * 0.8),
          SizedBox(height: w * 0.03),
          Text(
            text ?? '',
            style: Styles.textStyle18.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: w * 0.03),
          showAction
              ? SizedBox(
                  width: w * 0.5,
                  child: CustomButton(
                      buttonText: actionText!, onPressed: onActionPressed))
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
