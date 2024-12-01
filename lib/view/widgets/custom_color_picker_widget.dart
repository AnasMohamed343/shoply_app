import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:shoply/view/widgets/custom_button.dart';
import 'package:shoply/view_model/explore_screen_view_model.dart';

class CustomColorPickerWidget extends StatelessWidget {
  void Function(dynamic)? onSaved;
  Color? currentColor;
  CustomColorPickerWidget({super.key, this.onSaved, this.currentColor});

//   Color pickerColor = Color(0xff443a49);
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Text('Product Color', style: Styles.textStyle16),
        SizedBox(height: 15.h),
        GetBuilder<ExploreScreenViewModel>(
            init: ExploreScreenViewModel(),
            builder: (controller) {
              return Container(
                height: h * 0.06,
                width: w * 0.12,
                decoration: BoxDecoration(
                  color: currentColor,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: MaterialButton(
                  shape: const CircleBorder(),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Pick a color!'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: controller.pickerColor!,
                              onColorChanged: controller.changeColor,
                              colorPickerWidth: 300.0,
                              pickerAreaHeightPercent: 0.7,
                              enableAlpha: false,
                              displayThumbColor: true,
                              paletteType: PaletteType.hsv,
                              pickerAreaBorderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            CustomButton(
                                buttonText: 'Got it',
                                onPressed: () {
                                  controller.color = controller.pickerColor;
                                  onSaved;
                                  Get.back();
                                }),
                          ],
                        );
                      },
                    );
                  },
                ),
                //padding: const EdgeInsets.all(8.0),
              );
            }),
      ],
    );
  }
}
