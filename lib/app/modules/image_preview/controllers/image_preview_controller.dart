import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ImagePreviewController extends GetxController {
  String? imageUrl;

  @override
  void onInit() {
    super.onInit();
    if(Get.arguments != null){
      imageUrl = Get.arguments["image"];
      if (kDebugMode) {
        print(imageUrl);
      }
    }
  }

}
