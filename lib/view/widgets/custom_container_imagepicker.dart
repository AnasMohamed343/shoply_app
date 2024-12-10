import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoply/constants.dart';

class CustomContainerImagePicker extends StatelessWidget {
  ImageProvider<Object>? backgroundImage;
  BoxShape shape = BoxShape.rectangle;
  BorderRadiusGeometry? borderRadius;
  double? height, width;
  CustomContainerImagePicker(
      {super.key,
      this.backgroundImage,
      this.shape = BoxShape.rectangle,
      this.borderRadius,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 60.w),
      height: height ?? h / 4,
      width: width ?? w * 0.2,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: backgroundImage == null
            ? kGreyColor.withOpacity(0.6)
            : Colors.transparent,
        image: DecorationImage(
          image: backgroundImage ?? Image.network('').image,
          fit: BoxFit.cover,
        ),
        shape: shape,
      ),
      child: Icon(
        Icons.add_a_photo_outlined,
        color: Colors.white,
        size: 30.sp,
      ),
    );
  }
}
