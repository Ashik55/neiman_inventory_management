

import 'package:flutter/material.dart';

import '../../data/models/Products.dart';
import '../../utils/colors.dart';
import '../../utils/dimens.dart';
import '../../utils/utility.dart';
import 'chip_widget.dart';
import 'custom_textfield.dart';
import 'custom_textwidget.dart';
import 'load_image.dart';

class ProductItem extends StatelessWidget {
  Products? products;
  Products? cartProduct;
  Function(Products? products) onclick;
  Function(Products? products) onAddtoCart;
  Function(Products? products) onDeleteClick;
  Function(Products? products) onIncrementClick;
  Function(Products? products) onDecrementClick;
  Function(Products? products) onPriceUpdate;
  Function(Products? products) onQuantityUpdate;
  int? index;
  String? lastOrderDate;

  ProductItem(
      {required this.products,
        required this.onclick,
        required this.onAddtoCart,
        required this.cartProduct,
        required this.onDeleteClick,
        required this.onIncrementClick,
        required this.onDecrementClick,
        required this.onPriceUpdate,
        required this.onQuantityUpdate,
        required this.lastOrderDate,
        this.index});

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
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimens.basePaddingNone),
                    child: cartProduct != null
                        ? Row(
                      children: [
                        Expanded(
                          child: TextField(
                            // controller: controller.priceController,
                            textAlign: TextAlign.center,
                            // keyboardType: TextInputType.number,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            textInputAction: TextInputAction.done,
                            controller: TextEditingController(
                                text:
                                "${getSimpleFraction(value: "${cartProduct?.salesPrice}", fractionDigit: 2)}"),
                            onSubmitted: (value) {
                              if (value.isNotEmpty == true) {
                                cartProduct?.salesPrice =
                                    double.parse(value);
                                onPriceUpdate(cartProduct);
                              } else {
                                cartProduct?.salesPrice =
                                    cartProduct?.salesPriceConverted;
                                onPriceUpdate(cartProduct);
                              }
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () => onDecrementClick(cartProduct),
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                            child: CTextField(
                              controller: TextEditingController(
                                  text:
                                  "${getSimpleFraction(value: "${cartProduct?.quantity}")}"),
                              hintText: '1',
                              onSubmitted: (value) {
                                if (value?.isNotEmpty == true) {
                                  cartProduct?.quantity =
                                      double.parse("$value");
                                  onQuantityUpdate(cartProduct);
                                } else {
                                  cartProduct?.quantity = 0;
                                  onQuantityUpdate(cartProduct);
                                }
                              },
                              textInputType: const TextInputType.numberWithOptions(
                                  signed: true, decimal: true),
                              inputAction: TextInputAction.done,
                              textAlign: TextAlign.center,
                              strokeColor: CustomColors.KPrimaryColor,
                              strokeWidth: 1.5,
                              radius: Dimens.radiusMin,
                            )),
                        IconButton(
                          onPressed: () => onIncrementClick(cartProduct),
                          icon: const Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () => onDeleteClick(products),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    )
                        : Row(
                      children: [
                        CText(
                          '\$  ${getSimpleFraction(value: "${products?.salesPrice}", fractionDigit: 2)}',
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        ChipWidget(
                          text: "Add to cart".toUpperCase(),
                          radius: Dimens.radiusExtraLarge,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontWeight: FontWeight.w600,
                          onClick: () => onAddtoCart(products),
                          elevation: 0,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimens.basePaddingNone),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Container(
                        //   width: 20,
                        //   height: 20,
                        //   decoration: BoxDecoration(
                        //       shape: BoxShape.circle, color: Colors.red),
                        // ),
                        CText('${products?.itemNumber}'),
                        // CText('SC : ${products?.salesCount}'),

                        if (lastOrderDate != null)
                          CText(
                            getFormattedDate(lastOrderDate),
                            fontSize: Dimens.textRegular,
                            textColor: CustomColors.KPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        const SizedBox(
                          width: 1,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}