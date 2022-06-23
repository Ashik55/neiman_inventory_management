import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/utils/utility.dart';

import '../../../api/repository/product_repository.dart';
import '../../../data/remote/DeliveryPurchaseItem.dart';
import '../../../data/remote/PurchaseDetailsItem.dart';
import '../../base/base_controller.dart';

class DeliveryPurchaseDetailsController extends BaseController {
  DeliveryPurchaseItem? deliveryPurchaseItem;
  final ProductRepository _productRepository = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<PurchaseDetailsItem> deliveryPurchaseDetailsItemList = [];

  @override
  void onInit() {
    super.onInit();
    deliveryPurchaseItem = Get.arguments["data"];
    printObject(data: deliveryPurchaseItem);
    getDeliveryPurchaseDetails();
  }

  void getDeliveryPurchaseDetails() async {
    startLoading();
    deliveryPurchaseDetailsItemList = await _productRepository
        .getDeliveryPurchaseDetails(deliveryPurchaseItem: deliveryPurchaseItem);
    stopLoading();
  }

  onPurchaseClick(PurchaseDetailsItem? deliveryPurchaseItem) {}
}
