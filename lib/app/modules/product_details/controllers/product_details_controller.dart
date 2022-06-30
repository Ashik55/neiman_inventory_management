import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/modules/home/controllers/home_controller.dart';

import '../../../data/local_storage/local_storage.dart';
import '../../../data/models/Products.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/toaster.dart';
import '../../../utils/utility.dart';

class ProductDetailsController extends GetxController {
  LocalStorage localStorage = Get.find();
  HomeController productController = Get.find();

  late PageController pageController;
  late int indexToShow;
  List<String> image_list = [];
  int selectedIndex = 1;
  bool showQuantity = false;
  String? listType;
  bool isSearchSelected = false;
  bool loading = false;
  String? costVisibleIndex;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      indexToShow = Get.arguments["index"];
      listType = Get.arguments["list"];
      if (listType == "search") {
        isSearchSelected = true;
      } else {
        isSearchSelected = false;
      }
      selectedIndex = indexToShow;
      print("indexToShow : $indexToShow");
      pageController = PageController(
          initialPage: indexToShow, keepPage: true, viewportFraction: 1);

      update();
    } else {
      pageController = PageController();
      update();
    }
  }

  @override
  void onReady() {
    super.onReady();

  }



  Products? getCurrentProduct() {
    return productController.productList[selectedIndex];
  }

  onpageChange(int index) {
    print(index);
    selectedIndex = index;

  }

  copySKU() {
    Clipboard.setData(ClipboardData(text: ""));
    showMessageSnackbar(message: "Text copied to clipboard");
  }

  onImageClick(Products? products) {
    Get.toNamed(Routes.IMAGE_PREVIEW, arguments: {
      "image": getRegularImageUrl(products?.pictureId),
    });
  }






}