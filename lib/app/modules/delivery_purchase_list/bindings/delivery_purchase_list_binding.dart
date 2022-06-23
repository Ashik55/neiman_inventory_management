import 'package:get/get.dart';

import '../controllers/delivery_purchase_list_controller.dart';

class DeliveryPurchaseListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryPurchaseListController>(
      () => DeliveryPurchaseListController(),
    );
  }
}
