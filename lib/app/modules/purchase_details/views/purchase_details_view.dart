import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:neiman_inventory/app/modules/base/base_controller.dart';
import 'package:neiman_inventory/app/modules/base/base_view.dart';

import '../../../data/remote/PurchaseItem.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimens.dart';
import '../../../utils/utility.dart';
import '../../components/custom_textwidget.dart';
import '../controllers/purchase_details_controller.dart';

class PurchaseDetailsView extends GetView<PurchaseDetailsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseDetailsController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: CText(
                  'Purchase Details',
                  fontSize: Dimens.appbarTextSize,
                  textColor: Colors.white,
                ),
              ),
              body: BaseView(
                showLoading: controller.loading,
                child: GridView.builder(
                    itemCount: controller.purchaseList.length,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.basePaddingNone),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            getOrientation(context) == Orientation.portrait
                                ? 1
                                : 2,
                        childAspectRatio:
                            getOrientation(context) == Orientation.portrait
                                ? 2.8
                                : 2.8),
                    itemBuilder: (BuildContext context, int index) =>
                        PurchaseProductItemView(
                          purchaseItem: controller.purchaseList[index],
                          onclick: (PurchaseItem? purchaseItem) => controller
                              .onPurchaseItemClick(purchaseItem: purchaseItem),
                        )),
              ),
            ));
  }
}

class PurchaseProductItemView extends StatelessWidget {
  PurchaseItem? purchaseItem;
  Function(PurchaseItem? purchaseItem) onclick;

  PurchaseProductItemView({required this.purchaseItem, required this.onclick});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.radiusMin),
      ),
      child: InkWell(
        onTap: () => onclick(purchaseItem),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Dimens.basePaddingLarge,
              horizontal: Dimens.basePadding),
          child: Column(
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
                    CText(
                      'Qty Srtock : ${purchaseItem?.qtyStock}',
                      fontSize: Dimens.textMid,
                      maxLines: 2,
                    ),
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
                    CText(
                      'Items Number : ${purchaseItem?.itemsNumber}',
                      fontSize: Dimens.textMid,
                      maxLines: 2,
                    ),
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
