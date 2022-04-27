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
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimens.basePaddingLarge,
                  horizontal: Dimens.basePadding),
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
                      textColor: CustomColors.KPrimaryColor,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  CText(
                    'Cat : ${products?.categoryName}',
                    textAlign: TextAlign.center,
                  ),
                  CText(
                    'Br : ${products?.brandName}',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Card(
                    elevation: 0,
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.zero,
                    color: Colors.grey.shade200,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CText('${products?.itemNumber}'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
