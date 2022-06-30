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
                    physics: const BouncingScrollPhysics(),
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
                            boundaryMargin: const EdgeInsets.all(80),
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
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.all(Dimens.basePadding),
                        children: [
                          CText(
                            "${products?.name}",
                            fontSize: Dimens.textLarge,
                            maxLines: 2,
                            fontWeight: FontWeight.w600,
                            textColor: CustomColors.KDarkBlackColor,
                          ),

                          const SizedBox(height: 15),
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
                                  const SizedBox(
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
                                                    "Item Number : ${products?.itemNumber}",
                                                    textColor: CustomColors
                                                        .KLiteBlackColor,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2),
                                                  child: CText(
                                                    "Packing : ${products?.packingOrder}"
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
                                                    "Barcode : ${products?.barcode}"
                                                        .capitalize,
                                                    textColor: CustomColors
                                                        .KLiteBlackColor,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2),
                                                  child: CText(
                                                    "Vendore Name : ${products?.vendorName}"
                                                        .capitalize,
                                                    textColor: CustomColors
                                                        .KLiteBlackColor,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2),
                                                  child: CText(
                                                    "Category: ${products?.categoryName}",
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2),
                                                  child: CText(
                                                    "Qty: ${products?.qty}",
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
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
