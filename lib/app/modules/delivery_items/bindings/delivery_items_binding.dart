import 'package:get/get.dart';

import '../controllers/delivery_items_controller.dart';

class DeliveryItemsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryItemsController>(
      () => DeliveryItemsController(),
    );
  }
}
