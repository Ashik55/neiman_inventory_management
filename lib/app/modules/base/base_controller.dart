import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/utils/toaster.dart';

import '../../api/repository/product_repository.dart';
import '../../data/local_storage/local_storage.dart';

class BaseController extends GetxController {
  bool loading = false;

  startLoading() {
    loading = true;
    update();
    if (kDebugMode) {
      print("loading : $loading");
    }
  }

  stopLoading() {
    loading = false;
    update();

    if (kDebugMode) {
      print("loading : $loading");
    }
  }
}
