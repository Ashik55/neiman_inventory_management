import 'package:get/get.dart';

import '../controllers/delivery_orders_controller.dart';

class DeliveryOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryOrdersController>(
      () => DeliveryOrdersController(),
    );
  }
}
