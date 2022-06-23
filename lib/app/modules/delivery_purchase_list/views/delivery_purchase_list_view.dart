import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/Purchase.dart';
import '../../../data/remote/DeliveryPurchaseItem.dart';
import '../../../data/remote/DeliveryPurchaseItem.dart';
import '../../../data/remote/PurchaseItem.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimens.dart';
import '../../../utils/utility.dart';
import '../../base/base_view.dart';
import '../../components/custom_textwidget.dart';
import '../../home/views/home_view.dart';
import '../controllers/delivery_purchase_list_controller.dart';

class DeliveryPurchaseListView extends GetView<DeliveryPurchaseListController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryPurchaseListController>(
        builder: (controller) => Scaffold(
            key: controller.scaffoldKey,
            backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
              title: CText(
                'Delivery Purchase',
                fontSize: Dimens.appbarTextSize,
                textColor: Colors.white,
              ),
            ),
            body: BaseView(
              showLoading: controller.loading,
              child: controller.deliveryPurchaseList.isEmpty == true
                  ? NoDataWidget(
                      isLoading: controller.loading,
                      dataName: "purchase",
                    )
                  : GridView.builder(
                      itemCount: controller.deliveryPurchaseList.length,
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
                                  ? 3.8
                                  : 2.35),
                      itemBuilder: (BuildContext context, int index) =>
                          DeliveryPurchase(
                        purchaseItem: controller.deliveryPurchaseList[index],
                        onClick: (DeliveryPurchaseItem? deliveryPurchaseItem) =>
                            controller.onPurchaseClick(deliveryPurchaseItem),
                      ),
                    ),
            )));
  }
}

class DeliveryPurchase extends StatelessWidget {
  DeliveryPurchaseItem? purchaseItem;
  Function(DeliveryPurchaseItem? _purchase) onClick;

  DeliveryPurchase({required this.purchaseItem, required this.onClick});

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
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: Row(
                  children: [
                    Expanded(
                      child: CText(
                        'Purchase Name',
                        textColor: CustomColors.KPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimens.textMid,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CText(
                        ': ${purchaseItem?.purchaseName}',
                        textColor: CustomColors.KPrimaryColor,
                        fontSize: Dimens.textMid,
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: Row(
                  children: [
                    Expanded(
                      child: CText(
                        'Status',
                        textColor: CustomColors.KPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimens.textMid,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CText(
                        ': ${purchaseItem?.status}',
                        textColor: CustomColors.KPrimaryColor,
                        fontSize: Dimens.textMid,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: Row(
                  children: [
                    Expanded(
                      child: CText(
                        'Date',
                        textColor: CustomColors.KPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimens.textMid,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CText(
                        ': ${getFormattedDate(purchaseItem?.createdAt)}',
                        textColor: CustomColors.KPrimaryColor,
                        fontSize: Dimens.textMid,
                      ),
                    )
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
