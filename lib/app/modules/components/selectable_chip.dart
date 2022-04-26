import 'package:flutter/material.dart';


import '../../data/models/Category.dart';
import '../../utils/colors.dart';
import '../../utils/dimens.dart';
import 'custom_textwidget.dart';

class SelectableChipWidget extends StatelessWidget {
  Category? category;
  Function(Category? category) onSelect;
  bool? isSelected = false;
  Color? backgroundColor;
  Color? textColor;
  Color? strokeColor;
  double? strokeWidth;

  double? fontSize;
  double? verticalPadding;
  double? horizontalPadding;
  double? radius;
  double? elevation;
  Widget? suffixwidget;
  Widget? prefixWidget;
  FontWeight? fontWeight;

  SelectableChipWidget({
    required this.category,
    required this.onSelect,
    required this.isSelected,
    this.backgroundColor,
    this.textColor,
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
      color: isSelected == true
          ? CustomColors.KPrimaryColor
          : Colors.grey.shade300,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? Dimens.radiusNone),
          side: BorderSide(
              color: strokeColor ?? Colors.transparent,
              width: strokeWidth ?? 1)),
      child: InkWell(
        onTap: () => onSelect(category),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding ?? 12,
              vertical: verticalPadding ?? 5),
          child: Center(
            child: CText(
              category?.name,
              textColor: isSelected == true ? Colors.white : Colors.black,
              fontSize: fontSize,
              fontWeight: fontWeight,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}
