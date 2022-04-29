
import 'package:get/get.dart';

import '../../api/repository/product_repository.dart';
import '../../data/local_storage/local_storage.dart';

class BaseController extends GetxController {
  final LocalStorage _localStorage = Get.find();
  final ProductRepository _productRepository = Get.find();

  bool loading = false;


  startLoading() {
    loading = true;
    update();
  }

  stopLoading() {
    loading = false;
    update();
  }

}