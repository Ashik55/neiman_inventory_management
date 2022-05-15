import 'package:flutter/material.dart';
import 'package:neiman_inventory/app/modules/components/rounded_button.dart';

import '../../data/models/Products.dart';
import '../../utils/colors.dart';
import '../../utils/dimens.dart';
import '../../utils/utility.dart';
import 'custom_textwidget.dart';
import 'load_image.dart';

class PurchaseProductItem extends StatelessWidget {
  Products? products;
  Function(Products? products) onclick;
  Function(Products? products) onReorderUpdate;
  Function(Products? products) onStockUpdate;
  Function(Products? products) onSubmitUpdate;

  PurchaseProductItem({
    required this.products,
    required this.onclick,
    required this.onReorderUpdate,
    required this.onStockUpdate,
    required this.onSubmitUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.radiusMin),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Dimens.basePaddingLarge, horizontal: Dimens.basePadding),
        child: Row(
          children: [
            InkWell(
              onTap: () => onclick(products),
              child: CLoadImage(
                height: 75,
                width: 75,
                imageUrl: getShortImageUrl(products?.pictureId),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: CText(
                      '${products?.name}',
                      fontSize: Dimens.textRegular,
                      // fontWeight: FontWeight.w600,
                      textColor: CustomColors.KPrimaryColor,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: 'Reorder',
                              border: OutlineInputBorder(),
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            textInputAction: TextInputAction.done,
                            onChanged: (value) {
                              if (value.isNotEmpty == true) {
                                products?.reOrder = double.parse(value);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: 'Stocks',
                              border: OutlineInputBorder(),
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            textInputAction: TextInputAction.done,
                            onChanged: (value) {
                              if (value.isNotEmpty == true) {
                                products?.stock = double.parse(value);

                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: CRoundedButton(
                        onClick: () => onSubmitUpdate(products),
                        text: "Submit",
                        width: getMaxWidth(context),
                        radius: Dimens.radiusNone),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
