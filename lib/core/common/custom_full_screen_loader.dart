import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shoply/core/common/widgets/custom_animation_loader_widget.dart';

// a utility class for managing a full screen loading dialog.
class CustomFullScreenLoader {
  // open a full screen loading dialog with a given text and animation

  static void openLoadingDialog(String? text, String animation) {
    showDialog(
      context:
          Get.overlayContext!, // use Get.overlayContext for overlay dialogs
      barrierDismissible: false,
      builder: (context) => PopScope(
          canPop: false,
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //const SizedBox(height: 250),
                CustomAnimationLoaderWidget(
                    animationPath: animation, text: text),
              ],
            ),
          )),
    );
  }

  // stop the currently open loading dialog
  static stopLoadingDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
