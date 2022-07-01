import 'package:flutter/material.dart';

import '../../data/models/title_id_model.dart';
import '../../utils/colors.dart';
import '../../utils/dimens.dart';
import 'custom_textwidget.dart';

class CDropdown extends StatelessWidget {
  Function(String? id) onChange;
  List<TitleIDModel>? itemList;
  Color? backgroundColor;
  Color? textColor;
  Color? strokeColor;
  double? textSize;
  bool? isDisable = false;

  CDropdown({
    required this.itemList,
    required this.onChange,
    this.backgroundColor,
    this.textColor,
    this.textSize,
    this.strokeColor,
    this.isDisable,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.radiusMin),
            side: BorderSide(
                color: strokeColor ?? CustomColors.KPrimaryColorLite)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: DropdownButtonFormField(
                decoration: const InputDecoration.collapsed(hintText: ''),
                value: itemList?.first.id,
                style: TextStyle(
                    color: isDisable == true
                        ? Colors.grey.shade400
                        : textColor ?? CustomColors.KLiteBlackColor),
                icon: Icon(Icons.keyboard_arrow_down,
                    color: isDisable == true
                        ? Colors.grey.shade400
                        : textColor ?? CustomColors.KLiteBlackColor),
                selectedItemBuilder: (BuildContext context) {
                  return itemList!.map<Widget>((TitleIDModel titleIDModel) {
                    return DropdownMenuItem(
                        value: titleIDModel.id,
                        child: CText(
                          '${titleIDModel.title}',
                          fontSize: textSize,
                          textColor: textColor,
                        ));
                  }).toList();
                },
                items: itemList?.map((TitleIDModel titleIDModel) {
                  return DropdownMenuItem(
                      value: titleIDModel.id,
                      child: CText(
                        '${titleIDModel.title}',
                        fontSize: textSize,
                      ));
                }).toList(),
                onChanged: isDisable == true ? null : onChange),
          ),
        ),
      ),
    );
  }
}
