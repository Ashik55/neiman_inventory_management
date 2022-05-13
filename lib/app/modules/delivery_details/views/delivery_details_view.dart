import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/data/models/DeliveryOrder.dart';
import 'package:neiman_inventory/app/data/models/SalesOrderItem.dart';
import 'package:neiman_inventory/app/modules/base/base_view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../data/models/Purchase.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimens.dart';
import '../../../utils/utility.dart';
import '../../components/custom_textwidget.dart';
import '../../components/load_image.dart';
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
              child: controller.salesOrderList.isEmpty == true
                  ? NoDataWidget(
                      isLoading: controller.loading,
                      dataName: "purchase",
                    )
                  : Column(
                      children: [
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
                          child: GridView.builder(
                              itemCount: controller.salesOrderList.length,
                              // itemCount: controller.purchaseList.length,
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.basePaddingNone),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: getOrientation(context) ==
                                              Orientation.portrait
                                          ? 1
                                          : 2,
                                      childAspectRatio:
                                          getOrientation(context) ==
                                                  Orientation.portrait
                                              ? 2.8
                                              : 2.8),
                              itemBuilder: (BuildContext context, int index) =>
                                  // SalesItem(
                                  //   salesOrderItem: controller.salesOrderList[0],
                                  //   onClick: (SalesOrderItem? salesOrderItem) =>
                                  //       controller.onSalesItemClick(salesOrderItem),
                                  // ),

                                  InkWell(
                                    onTap: ()=> controller.onItemClick(),
                                    child: SalesDetailsItemView(
                                      salesDetailsItem:
                                          controller.salesOrderList[index],
                                      allPacked: controller.isAllPacked(controller.salesOrderList[index]),


                                    ),
                                  )),
                        ),
                      ],
                    ),
            )));
  }
}



class SalesDetailsItemView extends StatelessWidget {
  SalesOrderItem? salesDetailsItem;
  bool? allPacked;

  SalesDetailsItemView({required this.salesDetailsItem, required this.allPacked});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: allPacked == true ? Colors.green.shade100 : Colors.yellow.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.radiusMin),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Dimens.basePaddingLarge, horizontal: Dimens.basePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: CText(
                'Name : ${salesDetailsItem?.name}',
                fontSize: Dimens.textMid,
                fontWeight: FontWeight.w600,
                textColor: CustomColors.KPrimaryColor,
                maxLines: 2,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CText(
                    'Quantity : ${salesDetailsItem?.qty}',
                    fontSize: Dimens.textMid,
                    maxLines: 2,
                  ),
                  CText(
                    'Delivered : ${salesDetailsItem?.delivered}',
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
                    'Unit Price : \$${salesDetailsItem?.unitPrice}',
                    fontSize: Dimens.textMid,
                    maxLines: 2,
                  ),
                  CText(
                    'Total Price : \$${salesDetailsItem?.totalPrice}',
                    fontSize: Dimens.textMid,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
