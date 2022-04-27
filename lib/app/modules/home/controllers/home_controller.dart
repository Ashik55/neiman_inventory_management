import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/api/repository/product_repository.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/local_storage/local_storage.dart';
import '../../../data/models/Products.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/toaster.dart';
import '../../../utils/utility.dart';

class HomeController extends GetxController {
  LocalStorage localStorage = Get.find();
  ProductRepository productRepository = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  String searcheText = "";
  String? sortBy;
  double totalPrice = 0;

  bool showLoading = false;
  List<Products> productList = [];

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    emitLoading();
    productList = await productRepository.getLocalProducts();
    stopLoading();
    productList = await productRepository.getProducts();

    stopLoading();
  }

  getFilteredProductsV3() async {
    emitLoading();
    productList = await productRepository.getFilterProductV3(sortBy: sortBy);
    if (kDebugMode) {
      print(productList.length);
    }
    stopLoading();
  }

  Future<void> openBarCodeScanner() async {
    if (await Permission.camera.request().isGranted) {
      if (kDebugMode) {
        print('open scanner');
      }
      String barcodeScanRes;
      // Platform messages may fail, so we use a try/catch PlatformException.
      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE);
        if (kDebugMode) {
          print(barcodeScanRes);
        }
      } on PlatformException {
        barcodeScanRes = 'Failed to get platform version.';
      }

      print(barcodeScanRes);

      if (barcodeScanRes.trim() != "-1") {
        searchController.text = barcodeScanRes;
        onSearchChange(searchController.text);
        update();
        showMessageSnackbar(message: barcodeScanRes);
      }
    } else {
      showMessageSnackbar(message: "Permission failed");
    }
  }

  onSearchChange(String text) async {
    searcheText = text;
    if (text.isNotEmpty) {
      productList = await productRepository.searchProduct(searchText: text);
      update();
    } else {
      productList = await productRepository.getLocalProducts();
    }
    update();
  }

  clearSearch() {
    searchController.text = "";
    onSearchChange(searchController.text);
    update();
  }

  resetFilters() async {
    sortBy = null;

    update();
    await getFilteredProductsV3();
  }

  emitLoading() {
    showLoading = true;
    update();
  }

  stopLoading() {
    showLoading = false;
    update();
  }

  onProductClick({Products? products}) {
    Get.toNamed(Routes.IMAGE_PREVIEW, arguments: {
      "image": getRegularImageUrl(products?.pictureId),
    });
  }

  onSortBySelect(String? id) async {
    if (sortBy == id) {
      sortBy = null;
    } else {
      sortBy = id;
    }
    update();
    await getFilteredProductsV3();
  }
}
