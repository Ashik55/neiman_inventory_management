import 'package:get/get.dart';
import 'package:neiman_inventory/app/api/provider/api_provider.dart';

import '../../data/models/UserModel.dart';

class AuthRepository extends GetxService {
  ApiProvider apiProvider = Get.find();

  Future<UserModel?> login() async {
    return await apiProvider.loginNow();
  }


}
