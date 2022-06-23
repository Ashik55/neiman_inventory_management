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
import '../../../data/remote/DeliverOrderStatusUpdateResponse.dart';
import '../../../utils/toaster.dart';

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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<SalesOrderItem> salesOrderList = [];
  List<SalesOrderItem> searchedSalesOrderList = [];
  List<SalesOrderItem> scannedSalesOrderList = [];
  List<String> scannedBarcodes = [];
  DeliveryOrder? deliveryOrder;
  bool showBarcode = false;

  //orderStatus
  String startPacking = "Started Packing";
  String holdPacking = "On Hold";
  String donePacking = "Ready Delivery";
  String awaitPacking = "Awaiting Packing";

  //St
  String searchText = "";

  @override
  void onInit() {
    super.onInit();
    deliveryOrder = Get.arguments["data"];
    printObject(data: deliveryOrder);
    getDeliveryDetailsList();
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
    salesOrderList = await _productRepository.getDeliveryDetails(
        salesId: deliveryOrder?.salesId);
    searchedSalesOrderList = salesOrderList;

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

  onSalesItemClick(SalesOrderItem? salesOrderItem) {}

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

  onItemClick() {
    if (kDebugMode) {
      print(scannedBarcodes);
    }
  }

  onDonePacking() async {
    disableBarcodeView();
    startLoading();
    DeliverOrderStatusUpdateResponse deliverOrderStatusUpdateResponse =
        await _productRepository.updateDeliveryStatus(
            orderID: deliveryOrder?.id, orderStatus: donePacking);

    await checkOrderStatus();

    showMessageSnackbar(message: "${deliverOrderStatusUpdateResponse.status}");
    stopLoading();
  }

  onHoldPacking() async {
    disableBarcodeView();
    startLoading();
    DeliverOrderStatusUpdateResponse deliverOrderStatusUpdateResponse =
        await _productRepository.updateDeliveryStatus(
            orderID: deliveryOrder?.id, orderStatus: holdPacking);

    await checkOrderStatus();

    showMessageSnackbar(message: "${deliverOrderStatusUpdateResponse.status}");
    stopLoading();
  }

  onStartPacking() async {
    startLoading();
    DeliverOrderStatusUpdateResponse deliverOrderStatusUpdateResponse =
        await _productRepository.updateDeliveryStatus(
            orderID: deliveryOrder?.id, orderStatus: startPacking);

    await checkOrderStatus();
    showMessageSnackbar(message: "${deliverOrderStatusUpdateResponse.status}");
    stopLoading();
  }

  checkOrderStatus() async {
    deliveryOrder =
        await _productRepository.getDeliveryOrder(orderID: deliveryOrder?.id);

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
}
