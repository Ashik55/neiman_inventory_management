import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/data/models/DeliveryOrder.dart';
import 'package:neiman_inventory/app/modules/base/base_view.dart';
import 'package:neiman_inventory/app/utils/inventory_utility.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimens.dart';
import '../../../utils/utility.dart';
import '../../components/custom_textwidget.dart';
import '../../home/views/home_view.dart';
import '../controllers/delivery_orders_controller.dart';

class DeliveryOrdersView extends GetView<DeliveryOrdersController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryOrdersController>(
        builder: (controller) => Scaffold(
            key: controller.scaffoldKey,
            backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
              title: CText(
                'Delivery ${controller.parentRoute == ParentRoute.deliveryOrders ? 'Orders' : "Purchase"}',
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
              showLoading: controller.baseLoading,
              child: controller.deliveryOrdersList.isEmpty == true
                  ? NoDataWidget(
                      isLoading: controller.baseLoading,
                      dataName: "purchase",
                    )
                  : GridView.builder(
                      itemCount: controller.deliveryOrdersList.length,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.basePaddingNone,
                          vertical: Dimens.basePaddingNone),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              getOrientation(context) == Orientation.portrait
                                  ? 1
                                  : 2,
                          childAspectRatio:
                              getOrientation(context) == Orientation.portrait
                                  ? 3.2
                                  : 4.0),
                      itemBuilder: (BuildContext context, int index) =>
                          DeliveryItem(
                        parentRoute: controller.parentRoute,
                        deliveryOrder: controller.deliveryOrdersList[index],
                        onClick: (DeliveryOrder? deliveryOrder) =>
                            controller.onDeliveryItemClick(deliveryOrder),
                      ),
                    ),
            )));
  }
}

class DeliveryItem extends StatelessWidget {
  ParentRoute? parentRoute;
  DeliveryOrder? deliveryOrder;
  Function(DeliveryOrder? deliveryOrder) onClick;

  DeliveryItem(
      {required this.deliveryOrder,
      required this.onClick,
      required this.parentRoute});

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
                        'Name : ',
                        textColor: CustomColors.KPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimens.textRegular,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CText(
                        '${parentRoute == ParentRoute.deliveryOrders ? deliveryOrder?.salesName : deliveryOrder?.purchaseName}',
                        textColor: CustomColors.KPrimaryColor,
                        fontSize: Dimens.textRegular,
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
                        'Status : ',
                        textColor: CustomColors.KPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimens.textRegular,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CText(
                        '${deliveryOrder?.status}',
                        textColor:
                            getColorByStatus(status: deliveryOrder?.status),
                        fontSize: Dimens.textRegular,
                        fontWeight: FontWeight.bold,
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
                        fontSize: Dimens.textRegular,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CText(
                        ': ${getFormattedDate(deliveryOrder?.createdAt)}',
                        textColor: CustomColors.KPrimaryColor,
                        fontSize: Dimens.textRegular,
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
