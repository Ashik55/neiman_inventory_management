import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/data/remote/POResponse.dart';
import 'package:neiman_inventory/app/data/remote/PostPurchaseResponse.dart';
import 'package:neiman_inventory/app/modules/base/base_controller.dart';
import 'package:neiman_inventory/app/modules/purchase/controllers/purchase_controller.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../api/repository/product_repository.dart';
import '../../../data/local_storage/local_storage.dart';
import '../../../data/models/Products.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/toaster.dart';
import '../../../utils/utility.dart';

class PoProductModel {
  String? purchaseId;
  Products? products;

  PoProductModel({this.purchaseId, this.products});
}

class PurchaseCreateController extends BaseController {
  LocalStorage localStorage = Get.find();
  ProductRepository productRepository = Get.find();
  PurchaseController purchaseController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  String? sortBy;
  double totalPrice = 0;
  List<Products> productList = [];
  List<PoProductModel> poProductList = [];

  Future<void> loadInitialData() async {
    startLoading();
    productList = await productRepository.getLocalProducts();
    if (productList.isNotEmpty) {
      stopLoading();
    }
    productList = await productRepository.getProducts();

    stopLoading();
  }

  getFilteredProductsV3() async {
    startLoading();
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

      if (kDebugMode) {
        print(barcodeScanRes);
      }

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
    if (text.isNotEmpty) {
      productList = await productRepository.searchProduct(searchText: text);
    } else {
      productList.clear();
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

  onLogoutClick() {
    localStorage.clearStorage();
    Get.offAllNamed(Routes.LOGIN);
  }

  onPurchaseClick() {
    Get.toNamed(Routes.PURCHASE);
  }

  onPOSubmit(Products? products) async {
    if (products?.reOrder != null && products?.stock != null) {
      startLoading();
      if (poProductList.indexWhere(
              (element) => element.products?.vendorID == products?.vendorID) ==
          -1) {
        PostPurchaseResponse postPurchaseResponse =
            await productRepository.postPurchase(products: products);
        if (postPurchaseResponse != null) {
          poProductList.add(PoProductModel(
              purchaseId: "${postPurchaseResponse.id}", products: products));

          PoResponse poResponse = await productRepository.createPO(
              products: products, purchaseID: "${postPurchaseResponse.id}");
          if (poResponse != null) {
            showMessageSnackbar(message: "Purchase Order Created Successfully");
          }

          //reload previous page
          purchaseController.onInit();
        }
      } else {
        int index = poProductList.indexWhere(
            (element) => element.products?.vendorID == products?.vendorID);
        PoResponse poResponse = await productRepository.createPO(
            products: products,
            purchaseID: "${poProductList[index].purchaseId}");
        if (poResponse != null) {
          showMessageSnackbar(message: "Purchase Order Created Successfully");
        }
      }

      stopLoading();
    } else {
      showMessageSnackbar(message: "Please add reorder & stock amount");
    }
  }

// @override
// void onClose() async {
//   super.onClose();
//   if (kDebugMode) {
//     print("closing PO PAGEEE");
//   }
//   List<Products> vendorProductList = [];
//   for (var poProductElement in poProductList) {
//     if (vendorProductList.indexWhere(
//             (element) => element.vendorID == poProductElement.vendorID) ==
//         -1) {
//       if (kDebugMode) {
//         print(poProductElement.vendorName);
//       }
//       vendorProductList.add(poProductElement);
//       PostPurchaseResponse postPurchaseResponse =
//           await productRepository.postPurchase(products: poProductElement);
//       if (postPurchaseResponse != null &&
//           poProductElement == poProductList.last) {
//         showMessageSnackbar(message: "Purchase Order Created Successfully");
//         PurchaseController purchaseController = Get.find();
//         purchaseController.onInit();
//       }
//     }
//   }
// }

}
