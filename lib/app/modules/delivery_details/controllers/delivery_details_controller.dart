import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/api/repository/product_repository.dart';
import 'package:neiman_inventory/app/data/models/Purchase.dart';
import 'package:neiman_inventory/app/data/models/SalesOrderItem.dart';
import 'package:neiman_inventory/app/modules/base/base_controller.dart';
import 'package:neiman_inventory/app/routes/app_pages.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../data/local_storage/local_storage.dart';
import '../../../data/models/DeliveryOrder.dart';
import '../../../utils/toaster.dart';

class DeliveryDetailsController extends BaseController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  final LocalStorage _localStorage = Get.find();
  final ProductRepository _productRepository = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<SalesOrderItem> salesOrderList = [];
  DeliveryOrder? deliveryOrder;

  @override
  void onInit() {
    super.onInit();
    deliveryOrder = Get.arguments["data"];

    if (kDebugMode) {
      print("deliveryOrder");
      print(json.encode(deliveryOrder));
    }
    getDeliveryDetailsList();
  }

  void getDeliveryDetailsList() async {
    startLoading();
    salesOrderList = await _productRepository.getDeliveryDetails(
        salesId: deliveryOrder?.salesId);
    stopLoading();
  }

  onSalesItemClick(SalesOrderItem? salesOrderItem) {}

  Future<void> openBarCodeScanner() async {
    if (await Permission.camera.request().isGranted) {
      if (kDebugMode) {
        print('open scanner');
      }
      String barcodeScanResult;
      // Platform messages may fail, so we use a try/catch PlatformException.
      try {
        barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      } on PlatformException {
        barcodeScanResult = 'Failed to get platform version.';
      }

      if (kDebugMode) {
        print(barcodeScanResult);
      }

      if (barcodeScanResult.trim() != "-1") {
        // barcodeScanResult;
        // update();
        showMessageSnackbar(message: barcodeScanResult);
      }
    } else {
      showMessageSnackbar(message: "Permission failed");
    }
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      showMessageSnackbar(message: "Result : ${result?.code}");
      update();
    });
  }

}
