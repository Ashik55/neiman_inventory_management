import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/api/repository/product_repository.dart';
import 'package:neiman_inventory/app/data/models/Purchase.dart';
import 'package:neiman_inventory/app/modules/base/base_controller.dart';

import '../../../data/local_storage/local_storage.dart';

class PurchaseController extends BaseController {
  final LocalStorage _localStorage = Get.find();
  final ProductRepository _productRepository = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<Purchase> purchaseList = [];

  @override
  void onInit() {
    super.onInit();
    getPurchaseList();
  }

  void getPurchaseList() async {
    startLoading();
    purchaseList = await _productRepository.getPurchaseList();
    stopLoading();
  }

  onPurchaseClick(Purchase? purchase) {}
}
