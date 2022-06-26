import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get.dart';
import '../../../data/models/Purchase.dart';
import '../../../data/remote/DeliveryPurchaseItem.dart';
import '../../../data/remote/DeliveryPurchaseItem.dart';
import '../../../data/remote/PurchaseDetailsItem.dart';
import '../../../data/remote/PurchaseItem.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimens.dart';
import '../../../utils/utility.dart';
import '../../base/base_view.dart';
import '../../components/custom_textwidget.dart';
import '../../delivery_details/views/delivery_details_view.dart';
import '../../home/views/home_view.dart';
import '../controllers/delivery_purchase_details_controller.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/data/models/SalesOrderItem.dart';
import 'package:neiman_inventory/app/modules/base/base_view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimens.dart';
import '../../../utils/utility.dart';
import '../../components/chip_widget.dart';
import '../../components/custom_textwidget.dart';
import '../../components/load_image.dart';
import '../../components/rounded_button.dart';
import '../../home/views/home_view.dart';

class DeliveryPurchaseDetailsView
    extends GetView<DeliveryPurchaseDetailsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryPurchaseDetailsController>(
        builder: (controller) => Scaffold(
            key: controller.scaffoldKey,
            backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
              title: CText(
                'Delivery Order Items',
                fontSize: Dimens.appbarTextSize,
                textColor: Colors.white,
              ),
              actions: [
                IconButton(
                  icon: CAssetImage(
                    imagePath: 'images/barcode.png',
                    imageColor: Colors.white,
                  ),
                  onPressed: () => controller.enableBarcodeView(),
                ),
              ],
            ),
            body: BaseView(
              showLoading: controller.loading,
              child:NoDataWidget(
                isLoading: controller.loading,
                dataName: "purchase",
              )

            )));
  }
}

class DeliveryPurchaseDetailsItemView extends StatelessWidget {
  PurchaseDetailsItem? purchaseItem;
  Function(PurchaseDetailsItem? _purchase) onClick;

  DeliveryPurchaseDetailsItemView({required this.purchaseItem, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.radiusMin),
      ),
      child: InkWell(
        onTap: () => onClick(purchaseItem),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 6,
              bottom: Dimens.basePaddingNone,
              left: Dimens.basePadding,
              right: Dimens.basePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: CText(
                  'Name : ${purchaseItem?.productName}',
                  fontSize: Dimens.textMid,
                  fontWeight: FontWeight.w600,
                  textColor: CustomColors.KPrimaryColor,
                  maxLines: 2,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CText(
                      'QTY Ordered : ${purchaseItem?.qty}',
                      fontSize: Dimens.textMid,
                      maxLines: 2,
                    ),
                    // CText(
                    //   'Qty Packed : $qtyPacked',
                    //   fontSize: Dimens.textMid,
                    //   maxLines: 2,
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CText(
                      'Barcode : ${purchaseItem?.barcode}',
                      fontSize: Dimens.textMid,
                      maxLines: 2,
                    ),
                    // CText(
                    //   'Purchase Name : ${purchaseItem?.purchaseName}',
                    //   fontSize: Dimens.textMid,
                    //   maxLines: 2,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}