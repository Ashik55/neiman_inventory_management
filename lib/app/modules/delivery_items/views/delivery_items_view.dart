import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:neiman_inventory/app/data/models/DeliveryOrder.dart';
import 'package:neiman_inventory/app/modules/base/base_view.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimens.dart';
import '../../../utils/utility.dart';
import '../../components/custom_textwidget.dart';
import '../../home/views/home_view.dart';
import '../controllers/delivery_items_controller.dart';

class DeliveryItemsView extends GetView<DeliveryItemsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryItemsController>(
        builder: (controller) => Scaffold(
            key: controller.scaffoldKey,
            backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
              title: CText(
                'Delivery Orders',
                fontSize: Dimens.appbarTextSize,
                textColor: Colors.white,
              ),
            ),
            // floatingActionButton: FloatingActionButton.extended(
            //     onPressed: () => controller.createPO(),
            //     icon: const Icon(Icons.add),
            //     label: CText(
            //       "Create PO",
            //       textColor: Colors.white,
            //     )),
            body: BaseView(
              showLoading: controller.loading,
              child: controller.deliveryOrdersList.isEmpty == true
                  ? NoDataWidget(
                      isLoading: controller.loading,
                      dataName: "purchase",
                    )
                  : GridView.builder(
                      itemCount: 10,
                      // itemCount: controller.purchaseList.length,
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
                                  ? 4.5
                                  : 4.35),
                      itemBuilder: (BuildContext context, int index) =>
                          DeliveryItem(
                        deliveryOrder: controller.deliveryOrdersList[index],
                        onClick: (DeliveryOrder? deliveryOrder) =>
                            controller.onDeliveryItemClick(deliveryOrder),
                      ),
                    ),
            )));
  }
}

class DeliveryItem extends StatelessWidget {
  DeliveryOrder? deliveryOrder;
  Function(DeliveryOrder? deliveryOrder) onClick;

  DeliveryItem({required this.deliveryOrder, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.radiusMin),
      ),
      child: InkWell(
        onTap: () => onClick(deliveryOrder),
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
                        ': ${deliveryOrder?.name}',
                        // ': ${deliveryOrder?.name ?? "Not available"}',
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
                        'Status ',
                        textColor: CustomColors.KPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimens.textMid,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CText(
                        ': ${deliveryOrder?.status}',
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
                        ': ${getFormattedDate(deliveryOrder?.createdAt)}',
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
