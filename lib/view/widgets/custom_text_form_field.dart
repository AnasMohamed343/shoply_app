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
  final Widget? prefixIcon, suffixIcon;
  final InputBorder? border;
  TextEditingController? controller = TextEditingController();
  bool readOnly;
  CustomTextFormField({
    super.key,
    this.hintText,
    this.fieldName,
    this.onSave,
    this.validator,
    this.fieldNameColor,
    this.hintTextColor,
    this.prefixIcon,
    this.border,
    this.controller,
    this.readOnly = false,
    this.suffixIcon,
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
          controller: controller,
          cursorColor: kPrimaryColor,
          onSaved: onSave,
          validator: validator,
          readOnly: readOnly,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Styles.textStyle14.copyWith(
                  color: hintTextColor ?? kGreyColor.withOpacity(0.5)),
              fillColor: Colors.white,
              hoverColor: kPrimaryColor,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              enabledBorder: border ??
                  UnderlineInputBorder(
                    borderSide: BorderSide(color: kLightGrey),
                  ),
              focusedBorder: border ??
                  const UnderlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
              border: border ??
                  UnderlineInputBorder(
                    borderSide: BorderSide(color: kLightGrey),
                  ),
              disabledBorder: border ??
                  UnderlineInputBorder(
                    borderSide: BorderSide(color: kLightGrey),
                  )),
        ),
      ],
    );
  }
}
