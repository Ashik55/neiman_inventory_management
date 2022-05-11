import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/api/repository/product_repository.dart';
import 'package:neiman_inventory/app/data/models/Purchase.dart';
import 'package:neiman_inventory/app/modules/base/base_controller.dart';
import 'package:neiman_inventory/app/routes/app_pages.dart';

import '../../../data/local_storage/local_storage.dart';
import '../../../data/models/DeliveryOrder.dart';


class DeliveryItemsController extends BaseController {
  final LocalStorage _localStorage = Get.find();
  final ProductRepository _productRepository = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<DeliveryOrder> deliveryOrdersList = [];

  @override
  void onInit() {
    super.onInit();
    getDeliveryOrderList();
  }

  void getDeliveryOrderList() async {
    startLoading();
    deliveryOrdersList = await _productRepository.getDeliveryOrders();
    stopLoading();
  }


  onDeliveryItemClick(DeliveryOrder? deliveryOrder) {
    Get.toNamed(Routes.DELIVERY_DETAILS, arguments: {"data": deliveryOrder});
  }



}
