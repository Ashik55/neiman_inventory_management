import 'package:get/get.dart';

import '../controllers/delivery_purchase_details_controller.dart';

class DeliveryPurchaseDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryPurchaseDetailsController>(
      () => DeliveryPurchaseDetailsController(),
    );
  }
}
