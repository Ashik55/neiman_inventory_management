import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimens.dart';

class CTextField extends StatelessWidget {
  Function(String?)? onChange;
  Function(String?)? onSubmitted;
  TextEditingController? controller;
  TextInputType? textInputType;

  bool? obscureText;
  bool? showStrokeColor;
  String? hintText;
  Icon? prefixIcon;
  Icon? suffixIcon;
  Widget? suffixWidget;
  Widget? prefix;
  double? width;
  double? height;
  double? radius;
  int? maxLines;
  Color? fillColor;
  Color? strokeColor;
  double? strokeWidth;
  Color? textColor;
  Color? hintColor;
  bool? autofocus;
  TextAlign? textAlign;
  double? fontSize;
  bool? enable;
  FontWeight? fontWeight;
  TextInputAction? inputAction;

  CTextField({
    required this.controller,
    this.onChange,
    this.onSubmitted,
    this.showStrokeColor,
    this.textInputType,
    required this.hintText,
    this.obscureText,
    this.width,
    this.height,
    this.maxLines,
    this.radius,
    this.fillColor,
    this.strokeColor,
    this.strokeWidth,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.autofocus,
    this.textAlign,
    this.fontSize,
    this.textColor,
    this.hintColor,
    this.enable,
    this.fontWeight,
    this.suffixWidget,
    this.inputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        width: width,
        child: TextField(
          onSubmitted: onSubmitted,
          enabled: enable ?? true,
          textInputAction: inputAction,
          textCapitalization: TextCapitalization.sentences,
          textAlign: textAlign ?? TextAlign.start,
          controller: controller,
          obscureText: obscureText ?? false,
          autofocus: autofocus ?? false,
          onChanged: onChange,
          decoration: InputDecoration(
              suffix: suffixWidget,
              suffixIcon: suffixIcon,
              filled: fillColor != null,
              fillColor: fillColor,
              prefixIcon: prefixIcon,
              prefix: prefix,
              counterText: '',
              hintText: hintText ?? "Email or Phone Number",
              hintStyle: TextStyle(
                  color: hintColor ?? Colors.grey.shade500,
                  fontSize: fontSize ?? Dimens.textRegular),
              contentPadding: textAlign != TextAlign.center
                  ? EdgeInsets.only(left: 15, top: 12, bottom: 12)
                  : EdgeInsets.only(left: 0, top: 12, bottom: 12),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: strokeColor ?? CustomColors.KPrimaryColorLite,
                    width: strokeWidth ?? 1),
                borderRadius:
                    BorderRadius.circular(radius ?? Dimens.radiusLarge),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: strokeColor ?? CustomColors.KPrimaryColorLite,
                    width: strokeWidth ?? 1),
                borderRadius:
                    BorderRadius.circular(radius ?? Dimens.radiusLarge),
              )),
          style: TextStyle(
              fontWeight: fontWeight ?? FontWeight.w500,
              fontSize: fontSize ?? Dimens.textLarge,
              color: textColor),
          keyboardType: textInputType ?? TextInputType.text,
          maxLines: maxLines ?? 1,
        ),
      ),
    );
  }
}
