
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/api/api_client.dart';

import '../../data/models/UserModel.dart';

class ApiProvider extends GetxService{
  ApiClient apiClient = Get.find();


  Future<UserModel?> loginNow() async {
    return apiClient.callGetApi(
      endpoint: "_login-endpoint",
      builder: (data) {
        if (kDebugMode) {
          print("data $data");
        }
        return data == null ? null : UserModel.fromJson(data);
      },
    );
  }



}