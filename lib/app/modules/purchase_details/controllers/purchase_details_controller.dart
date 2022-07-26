import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/modules/base/base_controller.dart';

import '../../../api/repository/product_repository.dart';
import '../../../data/models/Purchase.dart';
import '../../../data/remote/PurchaseItem.dart';

class PurchaseDetailsController extends BaseController {
  final ProductRepository _productRepository = Get.find();
  Purchase? purchase;
  List<PurchaseItem> purchaseList = [];

  @override
  void onInit() {
    super.onInit();
    purchase = Get.arguments["data"];
    getPurchaseDetails();
  }

  void getPurchaseDetails() async {
    startLoading();
    purchaseList =
        await _productRepository.getPurchaseDetails(purchaseID: purchase?.id);
    if (kDebugMode) {
      print(purchaseList);
    }
    stopLoading();
  }

  onPurchaseItemClick({PurchaseItem? purchaseItem}) {}
}
