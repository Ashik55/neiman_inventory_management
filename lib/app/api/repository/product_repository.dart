import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/api/provider/localdb_provider.dart';
import 'package:neiman_inventory/app/data/models/Purchase.dart';

import '../../data/models/Products.dart';
import '../../data/models/UserModel.dart';
import '../../utils/utility.dart';
import '../provider/api_provider.dart';

class ProductRepository extends GetxService {
  final ApiProvider _apiProvider = Get.find();
  final LocalDBProvider _localDBProvider = Get.find();

  Future<UserModel?> login() async {
    return await _apiProvider.loginNow();
  }

  Future<List<Products>> getProducts() async {
    bool result = await isInternetAvailable();
    if (result == true) {
      //Internet available
      if (kDebugMode) {
        print("internet avaialble");
      }
      return getRemoteProducts();
    } else {
      //Internet is not available
      if (kDebugMode) {
        print("internet not avaialble");
      }
      return getLocalProducts();
    }
  }

  Future<List<Products>> getRemoteProducts() async {
    final productList = await _apiProvider.getProductsList();
    for (var element in productList) {
      await _localDBProvider.insertProduct(element);
    }
    return getLocalProducts();
  }

  Future<List<Products>> getLocalProducts() async {
    return _localDBProvider.getAllProducts();
  }


  Future<List<Products>> searchProduct({String? searchText}) async {
    return _localDBProvider.searchProduct(searchText: searchText);
  }

  Future<List<Products>> getFilterProductV3({String? sortBy}) async {
    return _localDBProvider.getFilterProductV3(sortBy: sortBy);
  }

  //purchase
  Future<List<Purchase>> getPurchaseList() async {
    return _apiProvider.getPurchaseList();
  }



}
