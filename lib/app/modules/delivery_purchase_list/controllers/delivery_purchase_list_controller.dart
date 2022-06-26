import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/repository/product_repository.dart';
import '../../../data/models/Purchase.dart';
import '../../../data/remote/DeliveryPurchaseItem.dart';
import '../../../routes/app_pages.dart';
import '../../base/base_controller.dart';

class DeliveryPurchaseListController extends BaseController {
  final ProductRepository _productRepository = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<DeliveryPurchaseItem> deliveryPurchaseList = [];

  @override
  void onInit() {
    super.onInit();

    getPurchaseList();
  }

  void getPurchaseList() async {
    startLoading();
    deliveryPurchaseList = await _productRepository.getDeliveryPurchase();
    stopLoading();
  }

  onPurchaseClick(DeliveryPurchaseItem? purchase) {
    Get.toNamed(Routes.DELIVERY_PURCHASE_DETAILS,
        arguments: {"data": purchase});
  }
}
