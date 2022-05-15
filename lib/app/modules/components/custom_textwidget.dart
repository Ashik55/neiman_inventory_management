import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimens.dart';

class CText extends StatelessWidget {
  String? text;
  double? fontSize;
  Color? textColor;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  double? textScaleFactor;
  int? maxLines;
  TextDecoration? decoration;

  CText(this.text,
      {this.fontSize,
      this.textColor,
      this.fontWeight,
      this.textAlign,
      this.textScaleFactor,
      this.decoration,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      overflow: TextOverflow.ellipsis,
      textScaleFactor: textScaleFactor,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      style: TextStyle(
        decoration: decoration,
        fontSize: fontSize ?? Dimens.textMid,
        color: textColor ?? CustomColors.KDarkBlackColor,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),

    );
  }
}
