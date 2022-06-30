import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/Products.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimens.dart';
import '../../../utils/utility.dart';
import '../../components/chip_widget.dart';
import '../../components/custom_textfield.dart';
import '../../components/custom_textwidget.dart';
import '../../components/load_image.dart';
import '../../components/rounded_button.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
        builder: (controller) => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                title: CText(
                  'Product Details',
                  fontSize: Dimens.appbarTextSize,
                  textColor: Colors.white,
                )),
            body: PageView.builder(
                controller: controller.pageController,
                onPageChanged: (index) => controller.onpageChange(index),
                itemCount: controller.productController.productList.length,
                itemBuilder: (context, index) => PageContent(
                  products: controller.productController.productList[index],
                  onImageClick: (Products? products) =>
                      controller.onImageClick(products),

                ))));
  }
}

class PageContent extends StatelessWidget {

  Products? products;

  Function(Products? products) onImageClick;


  PageContent({
    required this.products,

    required this.onImageClick,


  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
        builder: (controller) => Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getOrientation(context) == Orientation.portrait
                  ? 2
                  : getMaxWidth(context) * .08),
          child: Column(
            children: [
              Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      Container(
                        width: getMaxWidth(context),
                        color: Colors.white,
                        height: getMaxHeight(context) / 2.4,
                        child: InkWell(
                          onTap: () => onImageClick(products),
                          child: InteractiveViewer(
                            panEnabled: false,
                            // Set it to false to prevent panning.
                            boundaryMargin: EdgeInsets.all(80),
                            minScale: 0.5,
                            maxScale: 4,
                            child: CLoadImage(
                              imageUrl: getRegularImageUrl(products?.pictureId),
                            ),
                          ),

                          /*     PinchZoom(
                            child: CLoadImage(
                              imageUrl: getRegularImageUrl(products?.pictureId),
                            ),
                            resetDuration: const Duration(milliseconds: 100),
                            maxScale: 2.5,
                            onZoomStart: () {
                              print('Start zooming');
                            },
                            onZoomEnd: () {
                              print('Stop zooming');
                            },
                          ),*/
                        ),
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        padding: EdgeInsets.all(Dimens.basePadding),
                        children: [
                          CText(
                            "${products?.name}",
                            fontSize: Dimens.textLarge,
                            maxLines: 2,
                            fontWeight: FontWeight.w600,
                            textColor: CustomColors.KDarkBlackColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 30,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              children: [
                                ChipWidget(
                                  elevation: 0,
                                  text: products!.qty! > 0
                                      ? 'Stock'
                                      : "Out of stock",
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimens.textMid,
                                  radius: Dimens.radiusCircular,
                                  backgroundColor: products!.qty! > 0
                                      ? Colors.green
                                      : Colors.red,
                                  textColor: CustomColors.KWhite,
                                ),
                                if (controller.localStorage.getIsCustomer() !=
                                    true)
                                  SizedBox(
                                    width: 5,
                                  ),
                                if (controller.localStorage.getIsCustomer() !=
                                    true)
                                  ChipWidget(
                                    elevation: 0,
                                    text: controller.costVisibleIndex ==
                                        products?.id
                                        ? 'Cost : \$${getSimpleFraction(value: "${products?.cost}", fractionDigit: 2)}'
                                        : 'Cost',
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimens.textMid,
                                    radius: Dimens.radiusCircular,
                                    backgroundColor: Colors.grey.shade100,
                                    textColor: CustomColors.KDarkBlackColor,
                                  ),
                                SizedBox(
                                  width: 5,
                                ),
                                ChipWidget(
                                  elevation: 0,
                                  text:
                                  'Price : \$${getSimpleFraction(value: "${products?.salesPrice}", fractionDigit: 2)}',
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimens.textMid,
                                  radius: Dimens.radiusCircular,
                                  backgroundColor: Colors.grey.shade100,
                                  textColor: CustomColors.KDarkBlackColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                ChipWidget(
                                  elevation: 0,
                                  text: "${products?.itemNumber}",
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimens.textMid,
                                  radius: Dimens.radiusCircular,
                                  backgroundColor: Colors.grey.shade100,
                                  textColor: CustomColors.KDarkBlackColor,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Card(
                            elevation: 0,
                            color: Colors.grey.shade50,
                            margin: EdgeInsets.zero,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(Dimens.radiusMid)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: CText("Additional Information",
                                        fontSize: Dimens.textRegular,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: getMaxWidth(context),
                                    child: Card(
                                      elevation: 0,
                                      margin: EdgeInsets.zero,
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              Dimens.radiusMid)),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2),
                                                  child: CText(
                                                    "Quantity : ${getSimpleFraction(value: "${products?.qty}")}",
                                                    textColor: CustomColors
                                                        .KLiteBlackColor,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2),
                                                  child: CText(
                                                    "Category : ${products?.categoryName}"
                                                        .capitalize,
                                                    textColor: CustomColors
                                                        .KLiteBlackColor,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2),
                                                  child: CText(
                                                    "Brand : ${products?.brandName}"
                                                        .capitalize,
                                                    textColor: CustomColors
                                                        .KLiteBlackColor,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2),
                                                  child: CText(
                                                    "BC : ${products?.barcode}"
                                                        .capitalize,
                                                    textColor: CustomColors
                                                        .KLiteBlackColor,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2),
                                                  child: CText(
                                                    "Location Sellable : ${products?.locationSellable}",
                                                    textColor: CustomColors
                                                        .KLiteBlackColor,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2),
                                                  child: CText(
                                                    "Passover: ${products?.passover}",
                                                    textColor: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),


                        ],
                      ),
                    ],
                  )),

            ],
          ),
        ));
  }
}