import 'package:flutter/material.dart';

import '../../data/models/Products.dart';
import '../../utils/colors.dart';
import '../../utils/dimens.dart';
import '../../utils/utility.dart';
import 'chip_widget.dart';
import 'custom_textfield.dart';
import 'custom_textwidget.dart';
import 'load_image.dart';

class GridProductItem extends StatelessWidget {
  Products? products;
  Function(Products? products) onclick;

  GridProductItem({required this.products, required this.onclick});

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
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => onclick(products),
                child: CLoadImage(
                  height: 75,
                  width: 75,
                  imageUrl: getShortImageUrl(products?.pictureId),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
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
            CText('${products?.itemNumber}'),
            CText('${products?.categoryName}'),
            CText('${products?.brandName}'),
          ],
        ),
      ),
    );
  }
}
