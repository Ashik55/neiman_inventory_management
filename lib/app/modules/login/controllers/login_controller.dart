import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/api/repository/product_repository.dart';
import 'package:neiman_inventory/app/data/models/UserModel.dart';

import '../../../data/local_storage/local_storage.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/toaster.dart';
import '../../base/base_controller.dart';

class LoginController extends BaseController {
  final LocalStorage _localStorage = Get.find();
  ProductRepository productRepository = Get.find();

  bool rememberCheckbox = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  onRememberChange(bool? newValue) {
    if (kDebugMode) {
      print(newValue);
    }
    rememberCheckbox = newValue ?? false;
    update();
  }

  onLoginClick() async {
    if (userNameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      startLoading();

      _localStorage.setUserName(userNameController.text);
      _localStorage.setPassword(passwordController.text);

      final result = await productRepository.login();
      if (result != null) {
        if (rememberCheckbox) {
          _localStorage.setIsLoggedIn(true);
        }

        if (_localStorage.getIsCustomer() == true) {
          _localStorage.setCustomerID(result.user?.accountsIds?.first);
        } else {
          _localStorage.setSellerId(result.user?.id);
        }

        stopLoading();
        Get.offAllNamed(Routes.HOME);
      } else {
        stopLoading();
        showMessageSnackbar(
            message: 'Wrong username and password',
            backgroundColor: Colors.red);
      }
    } else {
      showMessageSnackbar(message: "Email & Password required");
    }
  }


}
