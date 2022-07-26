import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:neiman_inventory/app/api/repository/product_repository.dart';
import 'package:neiman_inventory/app/data/models/SalesOrderItem.dart';
import 'package:neiman_inventory/app/modules/base/base_controller.dart';
import 'package:neiman_inventory/app/modules/delivery_orders/controllers/delivery_orders_controller.dart';
import 'package:neiman_inventory/app/utils/utility.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../data/local_storage/local_storage.dart';
import '../../../data/models/DeliveryOrder.dart';
import '../../../data/models/title_id_model.dart';
import '../../../data/remote/BinItemModel.dart';
import '../../../data/remote/DeliverOrderStatusUpdateResponse.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimens.dart';
import '../../../utils/toaster.dart';
import '../../components/CDropdown.dart';
import '../../components/custom_textfield.dart';
import '../../components/custom_textwidget.dart';
import '../../components/rounded_button.dart';

// Start = Started Packing
// Done = Ready Delivery
// On Hold = On Hold

class DeliveryDetailsController extends BaseController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  TextEditingController searchController = TextEditingController();
  final LocalStorage _localStorage = Get.find();
  final ProductRepository _productRepository = Get.find();
  List<SalesOrderItem> salesOrderList = [];
  List<SalesOrderItem> searchedSalesOrderList = [];
  List<SalesOrderItem> scannedSalesOrderList = [];
  List<String> scannedBarcodes = [];
  DeliveryOrder? deliveryOrder;
  bool showBarcode = false;

  //orderStatus
  String startPacking = "Started Packing";
  String startDelivery = "Started Delivery";
  String holdPacking = "On Hold";
  String donePacking = "Ready Delivery";
  String awaitPacking = "Awaiting Packing";
  String awaitDelivery = "Awaiting Delivery";

  //St
  String searchText = "";

  ParentRoute? parentRoute;
  List<BinItemModel> binItems = [];
  List<TitleIDModel> binIDList = [];


  @override
  void onInit() {
    super.onInit();

    deliveryOrder = Get.arguments["data"];
    parentRoute = Get.arguments["parent"];
    printObject(data: deliveryOrder, title: "deliveryOrder data");
    if (kDebugMode) {
      print(parentRoute);
    }

    //get bins
    if(parentRoute == ParentRoute.deliveryPurchase){
      getBins();
    }

    getDeliveryDetailsList();
  }

  getBins() async {
    startLoading();
    binIDList.clear();
    final binList = await _productRepository.getBinList();
    for (var element in binList) {
      binIDList.add(TitleIDModel(id: element.id, title: element.name));
    }
    stopLoading();
  }

  clearSearch() {
    searchController.text = "";
    searchText = "";
    update();
  }

  onSearchChange(String text) async {
    searchText = text;
    if (text.isNotEmpty) {
      searchedSalesOrderList = salesOrderList
          .where((element) => element.barcode?.contains(text) == true)
          .toList();

      int scannedItemIndex = searchedSalesOrderList
          .indexWhere((element) => element.barcode == text);
      if (scannedItemIndex != -1) {
        showMessageSnackbar(message: "Barcode Scanned successfully");
        salesOrderList[scannedItemIndex].scanned = true;
        clearSearch();
        hideKeyboard();
      }
    } else {
      searchedSalesOrderList = salesOrderList;
    }
    sortSalesOrder();
  }

  void getDeliveryDetailsList() async {
    startLoading();


    print("deliveryOrder");
    print(deliveryOrder);
    printObject(data: deliveryOrder);
    salesOrderList = await _productRepository.getDeliveryDetails(
        deliveryOrder: deliveryOrder, parentRoute: parentRoute);


    searchedSalesOrderList = salesOrderList;

    stopLoading();
    if(parentRoute == ParentRoute.deliveryOrders){
      for (var element in searchedSalesOrderList) {
        final binList = await _productRepository.getBinItems(productID: element.productId);
        int itemIndex = searchedSalesOrderList.indexWhere((item) => item == element);
        if(itemIndex != -1){
          searchedSalesOrderList[itemIndex].binItems = binList;
          update();
        }
      }
    }


    stopLoading();
  }

  sortSalesOrder() {
    salesOrderList.sort((a, b) => a.scanned
        .toString()
        .toLowerCase()
        .compareTo(b.scanned.toString().toLowerCase()));
    searchedSalesOrderList.sort((a, b) => a.scanned
        .toString()
        .toLowerCase()
        .compareTo(b.scanned.toString().toLowerCase()));
    update();
  }



  enableBarcodeView() async {
    if (kDebugMode) {
      print("enableBarcodeView called");
    }
    if (deliveryOrder?.status == startPacking) {
      showBarcode = !showBarcode;
      update();
    } else {
      showMessageSnackbar(
          message: "Barcode only available for start packing",
          backgroundColor: Colors.red);
    }
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      if (result != null) {
        int scannedItemIndex = searchedSalesOrderList
            .indexWhere((element) => element.barcode == result.toString());
        if (scannedItemIndex != -1) {
          controller.pauseCamera();
          showMessageSnackbar(message: "Barcode Scanned successfully");
          salesOrderList[scannedItemIndex].scanned = true;
          disableBarcodeView();
          hideKeyboard();
          sortSalesOrder();
        }
      }
      showMessageSnackbar(message: "Result : ${result?.code}");
      update();
    });

    if (kDebugMode) {
      print(scannedBarcodes);
    }
  }

  int packedItem(SalesOrderItem salesOrderList) {
    String barcode = "${salesOrderList.barcode}";
    int scannedCount = 0;
    for (var element in scannedBarcodes) {
      if (element == barcode) scannedCount++;
    }
    return scannedCount;
  }

  bool isAllPacked(SalesOrderItem salesOrderList) {
    int qty = salesOrderList.qty?.toInt() ?? 1;
    String barcode = "${salesOrderList.barcode}";
    int scannedCount = 0;
    for (var element in scannedBarcodes) {
      if (element == barcode) scannedCount++;
    }
    return scannedCount >= qty;
  }

  onSalesDetailsItemClick({required SalesOrderItem? salesDetailsItem}) {
    //on item click
    if(parentRoute == ParentRoute.deliveryPurchase){

      showSalesDetailsItemUpdateBottomSheet(addBinItemClick: (String? binID, String? quantity) { 
        

      }, salesDetailsItem: salesDetailsItem);


    }


  }

  onDonePacking() async {
    disableBarcodeView();
    startLoading();
    DeliverOrderStatusUpdateResponse deliverOrderStatusUpdateResponse =
        await _productRepository.updateDeliveryStatus(
            deliveryOrder: deliveryOrder,
            parentRoute: parentRoute,
            orderStatus: donePacking);

    await checkOrderStatus();

    showMessageSnackbar(message: "${deliverOrderStatusUpdateResponse.status}");
    stopLoading();
  }

  onHoldPacking() async {
    disableBarcodeView();
    startLoading();
    DeliverOrderStatusUpdateResponse deliverOrderStatusUpdateResponse =
        await _productRepository.updateDeliveryStatus(
            deliveryOrder: deliveryOrder,
            parentRoute: parentRoute,
            orderStatus: holdPacking);

    await checkOrderStatus();

    showMessageSnackbar(message: "${deliverOrderStatusUpdateResponse.status}");
    stopLoading();
  }

  onStartPacking() async {
    startLoading();
    DeliverOrderStatusUpdateResponse deliverOrderStatusUpdateResponse =
        await _productRepository.updateDeliveryStatus(
            deliveryOrder: deliveryOrder,
            parentRoute: parentRoute,
            orderStatus: startPacking);

    await checkOrderStatus();
    showMessageSnackbar(message: "${deliverOrderStatusUpdateResponse.status}");
    stopLoading();
  }

  checkOrderStatus() async {
    deliveryOrder = await _productRepository.getDeliveryOrder(
        deliveryOrder: deliveryOrder, parentRoute: parentRoute);

    if (kDebugMode) {
      print(deliveryOrder?.status);
      print(deliveryOrder?.status == startPacking);
    }
    update();

    DeliveryOrdersController deliveryOrdersController = Get.find();
    await deliveryOrdersController.getDeliveryOrderList();
  }

  void disableBarcodeView() {
    showBarcode = false;
    update();
  }





  void showSalesDetailsItemUpdateBottomSheet(
      {required SalesOrderItem? salesDetailsItem,
        TitleIDModel? selectedBin,
        String? quantity,
        required Function(
            String? binID,
            String? quantity,
            )
        addBinItemClick}) {

    String? selectedBinID = selectedBin?.id ?? binIDList.first.id;
    TextEditingController binQuantityController = TextEditingController();
    TextEditingController quantityController = TextEditingController();

    if(salesDetailsItem != null){
      quantityController.text = "${salesDetailsItem.qty ?? 0}";
    }


    if (quantity != null) {
      quantityController.text = quantity;
    }

    showModalBottomSheet(
      shape:  const RoundedRectangleBorder(
          borderRadius:
          BorderRadius.vertical(top: Radius.circular(Dimens.radiusMid))),
      isScrollControlled: true,
      context: scaffoldKey.currentContext!,
      backgroundColor: Colors.white,
      builder: (context) => GetBuilder<DeliveryDetailsController>(
        builder: (controller) => Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: ListView(
            padding:
            const EdgeInsets.symmetric(horizontal: Dimens.basePaddingLarge),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  height: 4,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CText(
                  "Choose Bin",
                  fontWeight: FontWeight.w600,
                ),
              ),
              CDropdown(
                  itemList: binIDList,
                  isDisable: selectedBin != null,
                  strokeColor: Colors.grey,
                  selectedItem: selectedBin,
                  textColor: CustomColors.KPrimaryColor,
                  onChange: (selectedID) => selectedBinID = selectedID),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CText(
                  "Bin Quantity",
                  fontWeight: FontWeight.w600,
                ),
              ),
              CTextField(
                hintText: '0',
                textInputType: TextInputType.number,
                textAlign: TextAlign.start,
                controller: binQuantityController,
                strokeColor: Colors.grey,
                radius: Dimens.radiusMin,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CText(
                  "Recievable Quantity",
                  fontWeight: FontWeight.w600,
                ),
              ),
              CTextField(
                hintText: '0',
                textInputType: TextInputType.number,
                textAlign: TextAlign.start,
                controller: quantityController,
                strokeColor: Colors.grey,
                radius: Dimens.radiusMin,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimens.basePaddingLarge),
                child: CRoundedButton(
                    text: 'Add Bin Item',
                    onClick: () {
                      if (selectedBinID != null) {
                        if (quantityController.text.isNotEmpty) {
                          addBinItemClick(
                              selectedBinID, quantityController.text);
                        } else {
                          showMessageSnackbar(
                              message: "PLease enter valid quantity");
                        }
                      } else {
                        showMessageSnackbar(message: "PLease select Bin");
                      }
                    },
                    backgroundColor: CustomColors.KPrimaryColor,
                    width: getMaxWidth(context),
                    radius: Dimens.radiusNone),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
