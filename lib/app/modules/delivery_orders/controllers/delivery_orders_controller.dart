import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:neiman_inventory/app/api/repository/product_repository.dart';
import 'package:neiman_inventory/app/modules/base/base_controller.dart';
import 'package:neiman_inventory/app/routes/app_pages.dart';
import 'package:neiman_inventory/app/utils/utility.dart';

import '../../../data/local_storage/local_storage.dart';
import '../../../data/models/DeliveryOrder.dart';

enum ParentRoute { deliveryPurchase, deliveryOrders }

class DeliveryOrdersController extends BaseController {
  final LocalStorage _localStorage = Get.find();
  final ProductRepository _productRepository = Get.find();
  List<DeliveryOrder> deliveryOrdersList = [];
  ParentRoute? parentRoute;

  @override
  void onInit() {
    super.onInit();
    parentRoute = Get.arguments["data"];
    getDeliveryOrderList();
  }

  getDeliveryOrderList() async {
    startLoading();
    deliveryOrdersList =
        await _productRepository.getDeliveryOrders(parentRoute: parentRoute);
    stopLoading();
  }

  onDeliveryItemClick(DeliveryOrder? deliveryOrder) {
    Get.toNamed(Routes.DELIVERY_DETAILS,
        arguments: {"data": deliveryOrder, "parent": parentRoute});
  }
}
