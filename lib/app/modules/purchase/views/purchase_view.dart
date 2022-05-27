import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:neiman_inventory/app/modules/base/base_view.dart';

import '../../../data/models/Purchase.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimens.dart';
import '../../../utils/utility.dart';
import '../../components/custom_textwidget.dart';
import '../../home/views/home_view.dart';
import '../controllers/purchase_controller.dart';

class PurchaseView extends GetView<PurchaseController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseController>(
        builder: (controller) => Scaffold(
            key: controller.scaffoldKey,
            backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
              title: CText(
                'Purchase',
                fontSize: Dimens.appbarTextSize,
                textColor: Colors.white,
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () => controller.createPO(),
                icon: const Icon(Icons.add),
                label: CText(
                  "Create PO",
                  textColor: Colors.white,
                )),
            body: BaseView(
              showLoading: controller.loading,
              child: controller.purchaseList.isEmpty == true
                  ? NoDataWidget(
                      isLoading: controller.loading,
                      dataName: "purchase",
                    )
                  : GridView.builder(
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
                                  ? 2.35
                                  : 2.35),
                      itemBuilder: (BuildContext context, int index) =>
                          PurchaseItem(
                        purchase: controller.purchaseList[index],
                        onClick: (Purchase? purchase) =>
                            controller.onPurchaseClick(purchase),
                      ),
                    ),
            )));
  }
}

class PurchaseItem extends StatelessWidget {
  Purchase? purchase;
  Function(Purchase? _purchase) onClick;

  PurchaseItem({required this.purchase, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.radiusMin),
      ),
      child: InkWell(
        onTap: () => onClick(purchase),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 6,
              bottom: Dimens.basePaddingNone,
              left: Dimens.basePadding,
              right: Dimens.basePadding),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: Row(
                  children: [
                    Expanded(
                      child: CText(
                        'Name',
                        textColor: CustomColors.KPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimens.textMid,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CText(
                        ': ${purchase?.name}',
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
                        'Quantity ',
                        textColor: CustomColors.KPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimens.textMid,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CText(
                        ': ${purchase?.qty}',
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
                        'Status',
                        textColor: CustomColors.KPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimens.textMid,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CText(
                        ': ${purchase?.status}',
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
                        'Po Number',
                        textColor: CustomColors.KPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimens.textMid,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CText(
                        ': ${purchase?.poNumber}',
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
                        'Created By',
                        textColor: CustomColors.KPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimens.textMid,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CText(
                        ': \$ ${purchase?.createdByName}',
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
                        ': ${getFormattedDate(purchase?.createdAt)}',
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
