import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimens.dart';
import 'custom_textwidget.dart';

class CRoundedButton extends StatelessWidget {
  double? height;
  double? width;
  VoidCallback? onClick;
  Color? backgroundColor;
  String? text;
  double? radius;
  double? textSize;
  Color? textColor;
  FontWeight? fontWeight;

  CRoundedButton({
    required this.onClick,
    required this.text,
    this.height,
    this.width,
    this.backgroundColor,
    this.radius,
    this.textSize,
    this.textColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? Dimens.buttonRegular,
      width: width,
      child: ElevatedButton(
          child: CText(
            text ?? "Button",
            fontSize: textSize ?? Dimens.textRegular,
            fontWeight: fontWeight,
            textColor: textColor ?? Colors.white,
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  backgroundColor ?? CustomColors.KPrimaryColor),
              // <-- Button color
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(radius ?? Dimens.radiusLarge),
                      side: BorderSide.none))),
          onPressed: onClick),
    );
  }
}
