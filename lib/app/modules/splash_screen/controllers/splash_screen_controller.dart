import 'dart:async';

import 'package:get/get.dart';

import '../../../data/local_storage/local_storage.dart';
import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  final LocalStorage _localStorage = Get.find();

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    Timer(const Duration(seconds: 3), () {
      if (_localStorage.getIsLoggedIn() == true) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }
}
