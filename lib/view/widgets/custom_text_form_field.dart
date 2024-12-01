import 'package:shoply/constants.dart';
import 'package:shoply/core/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText, fieldName;
  final Function(String?)? onSave;
  final String? Function(String?)? validator;
  Color? fieldNameColor = kGreyColor,
      hintTextColor = kGreyColor.withOpacity(0.5);
  CustomTextFormField({
    super.key,
    this.hintText,
    this.fieldName,
    this.onSave,
    this.validator,
    this.fieldNameColor,
    this.hintTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldName ?? '',
          style: Styles.textStyle16.copyWith(color: fieldNameColor),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          cursorColor: kPrimaryColor,
          onSaved: onSave,
          validator: validator,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Styles.textStyle14.copyWith(color: hintTextColor),
              fillColor: Colors.white,
              hoverColor: kPrimaryColor,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kLightGrey),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: kLightGrey),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kLightGrey),
              )),
        ),
      ],
    );
  }
}
