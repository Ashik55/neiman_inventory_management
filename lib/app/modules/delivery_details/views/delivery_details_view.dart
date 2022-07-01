import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:neiman_inventory/app/data/models/SalesOrderItem.dart';
import 'package:neiman_inventory/app/modules/base/base_view.dart';
import 'package:neiman_inventory/app/modules/delivery_orders/controllers/delivery_orders_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimens.dart';
import '../../../utils/utility.dart';
import '../../components/chip_widget.dart';
import '../../components/custom_textwidget.dart';
import '../../components/load_image.dart';
import '../../components/rounded_button.dart';
import '../../home/views/home_view.dart';
import '../controllers/delivery_details_controller.dart';

class DeliveryDetailsView extends GetView<DeliveryDetailsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryDetailsController>(
        builder: (controller) => Scaffold(
            key: controller.scaffoldKey,
            backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
              title: CText(
                'Delivery ${controller.parentRoute == ParentRoute.deliveryOrders ? "Order" : "Purchase"} Items',
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
              showLoading: controller.baseLoading,
              child: controller.salesOrderList.isEmpty == true
                  ? NoDataWidget(
                      isLoading: controller.baseLoading,
                      dataName: "purchase",
                    )
                  : Column(
                      children: [
                        if (controller.deliveryOrder?.status ==
                                controller.awaitPacking ||
                            controller.deliveryOrder?.status ==
                                controller.holdPacking)
                          Padding(
                            padding: const EdgeInsets.all(Dimens.basePadding),
                            child: CRoundedButton(
                                onClick: () => controller.onStartPacking(),
                                text: "Start Packing",
                                backgroundColor: Colors.green,
                                width: getMaxWidth(context),
                                radius: Dimens.radiusNone),
                          ),
                        if (controller.deliveryOrder?.status ==
                            controller.startPacking)
                          Padding(
                            padding: const EdgeInsets.all(Dimens.basePadding),
                            child: CRoundedButton(
                                onClick: () => controller.onHoldPacking(),
                                text: "Hold Packing",
                                backgroundColor: Colors.red,
                                width: getMaxWidth(context),
                                radius: Dimens.radiusNone),
                          ),
                        if (controller.salesOrderList.isNotEmpty &&
                            controller.deliveryOrder?.status ==
                                controller.startPacking)
                          Padding(
                            padding: const EdgeInsets.only(
                                left: Dimens.basePadding,
                                right: Dimens.basePadding,
                                top: Dimens.basePadding),
                            child: TextFormField(
                              controller: controller.searchController,
                              onChanged: (e) => controller.onSearchChange(e),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Search Items',
                                border: const OutlineInputBorder(),
                                prefixIcon: const Icon(
                                  Icons.search,
                                ),
                                suffixIcon:
                                    controller.searchController.text.isNotEmpty
                                        ? IconButton(
                                            onPressed: () =>
                                                controller.clearSearch(),
                                            icon: const Icon(Icons.clear),
                                          )
                                        : null,
                              ),
                            ),
                          ),
                        if (controller.showBarcode)
                          Expanded(
                            flex: 2,
                            child: QRView(
                              key: controller.qrKey,
                              onQRViewCreated: controller.onQRViewCreated,
                            ),
                          ),
                        Expanded(
                          flex: 5,
                          child: controller.searchText.isNotEmpty &&
                                  controller.searchedSalesOrderList.isEmpty
                              ? Center(
                                  child: CText(
                                    "No Item Found",
                                    textColor: Colors.red,
                                    fontSize: Dimens.textRegular,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : GridView.builder(
                                  itemCount: controller.searchText.isEmpty
                                      ? controller.salesOrderList.length
                                      : controller
                                          .searchedSalesOrderList.length,
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimens.basePaddingNone),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              getOrientation(context) ==
                                                      Orientation.portrait
                                                  ? 1
                                                  : 2,
                                          childAspectRatio:
                                              getOrientation(context) ==
                                                      Orientation.portrait
                                                  ? 1.8
                                                  : 1.8),
                                  itemBuilder: (BuildContext context,
                                          int index) =>
                                      InkWell(
                                        onTap: () => controller.onItemClick(),
                                        child: SalesDetailsItemView(
                                          parentRoute: controller.parentRoute,
                                          salesDetailsItem: controller
                                                  .searchText.isEmpty
                                              ? controller.salesOrderList[index]
                                              : controller
                                                      .searchedSalesOrderList[
                                                  index],
                                          allPacked: controller.isAllPacked(
                                              controller.searchText.isEmpty
                                                  ? controller
                                                      .salesOrderList[index]
                                                  : controller
                                                          .searchedSalesOrderList[
                                                      index]),
                                          qtyPacked: controller.packedItem(
                                              controller.searchText.isEmpty
                                                  ? controller
                                                      .salesOrderList[index]
                                                  : controller
                                                          .searchedSalesOrderList[
                                                      index]),
                                        ),
                                      )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(Dimens.basePadding),
                          child: CRoundedButton(
                              onClick: () => controller.onDonePacking(),
                              text: "Done",
                              width: getMaxWidth(context),
                              radius: Dimens.radiusNone),
                        )
                      ],
                    ),
            )));
  }
}

class SalesDetailsItemView extends StatelessWidget {
  ParentRoute? parentRoute;
  SalesOrderItem? salesDetailsItem;
  bool? allPacked;
  int? qtyPacked;

  SalesDetailsItemView(
      {required this.salesDetailsItem,
      required this.allPacked,
      required this.parentRoute,
      required this.qtyPacked});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: allPacked == true || salesDetailsItem?.scanned == true
          ? Colors.green.shade100
          : Colors.yellow.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.radiusMin),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Dimens.basePaddingLarge, horizontal: Dimens.basePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: CText(
                'Name : ${parentRoute == ParentRoute.deliveryOrders ? salesDetailsItem?.productName : salesDetailsItem?.productName}',
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
                    'QTY Ordered : ${salesDetailsItem?.qty}',
                    fontSize: Dimens.textMid,
                    maxLines: 2,
                  ),
                  CText(
                    'Qty Packed : $qtyPacked',
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
                    'Barcode : ${salesDetailsItem?.barcode}',
                    fontSize: Dimens.textMid,
                    maxLines: 2,
                  ),
                  CText(
                    'Item Number : ${salesDetailsItem?.itemNumber}',
                    fontSize: Dimens.textMid,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            if (salesDetailsItem?.binItems?.isNotEmpty == true)
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: CText(
                  'Bin Items : ',
                  fontSize: Dimens.textMid,
                  fontWeight: FontWeight.w600,
                  textColor: CustomColors.KPrimaryColor,
                ),
              ),
            if (salesDetailsItem?.binItems?.isNotEmpty == true)
              ListView.builder(
                padding: const EdgeInsets.only(top: 5),
                itemCount: salesDetailsItem?.binItems?.length,
                shrinkWrap: true,
                // physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index2) => Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        'Bin Name : ${salesDetailsItem?.binItems?[index2].binName}',
                        fontSize: Dimens.textMid,
                        maxLines: 2,
                      ),
                      CText(
                        'Bin Quantity : ${salesDetailsItem?.binItems?[index2].qty}',
                        fontSize: Dimens.textMid,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
