import 'package:flutter/material.dart';

import '../../utils/dimens.dart';
import 'custom_textwidget.dart';

class ChipWidget extends StatelessWidget {
  VoidCallback? onClick;

  Color? backgroundColor;
  Color? textColor;
  Color? strokeColor;
  double? strokeWidth;
  String? text;
  double? fontSize;
  double? verticalPadding;
  double? horizontalPadding;
  double? radius;
  double? elevation;
  Widget? suffixwidget;
  Widget? prefixWidget;
  FontWeight? fontWeight;

  ChipWidget({
    this.onClick,
    this.backgroundColor,
    this.textColor,
    required this.text,
    this.verticalPadding,
    this.horizontalPadding,
    this.fontSize,
    this.elevation,
    this.radius,
    this.suffixwidget,
    this.prefixWidget,
    this.fontWeight,
    this.strokeColor,
    this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? Dimens.radiusNone),
          side: BorderSide(
              color: strokeColor ?? Colors.transparent,
              width: strokeWidth ?? 1)),
      child: InkWell(
        onTap: onClick,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding ?? 12,
              vertical: verticalPadding ?? 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (prefixWidget != null)
                Padding(
                    padding: const EdgeInsets.only(right: 4), child: prefixWidget),
              CText(
                text ?? "Brand New",
                textColor: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
              if (suffixwidget != null)
                Padding(padding: const EdgeInsets.only(left: 4), child: suffixwidget),
            ],
          ),
        ),
      ),
    );
  }
}
