import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/utils/toaster.dart';

import '../../api/repository/product_repository.dart';
import '../../data/local_storage/local_storage.dart';

class BaseController extends GetxController {
  final LocalStorage _localStorage = Get.find();
  final ProductRepository _productRepository = Get.find();

  bool loading = false;

  startLoading() {
    loading = true;
    update();

   /* Timer(const Duration(seconds: 25), () {
      if (loading) {
        showMessageSnackbar(
            message: "Loading timeout", backgroundColor: Colors.red);
      }
      stopLoading();
    });
    */

  }

  stopLoading() {
    loading = false;
    update();
  }
}
