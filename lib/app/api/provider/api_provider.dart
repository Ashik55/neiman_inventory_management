import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/api/client/api_client.dart';
import 'package:neiman_inventory/app/data/models/Purchase.dart';
import 'package:neiman_inventory/app/data/remote/POResponse.dart';

import '../../data/models/Products.dart';
import '../../data/models/UserModel.dart';

class ApiProvider extends GetxService {
  ApiClient apiClient = Get.find();

  static const String _product = '/product';
  static const String _purchase = '/Purchase';
  static const String _login = '/App/user';
  static const String _purchaseItem = '/PurchaseItems';

  Future<UserModel?> loginNow() async {
    return apiClient.callGetApi(
      endpoint: _login,
      builder: (data) {
        if (kDebugMode) {
          print("data $data");
        }
        return data == null ? null : UserModel.fromJson(data);
      },
    );
  }

  Future<List<Products>> getProductsList() async {
    return apiClient.callGetApi(
      endpoint: _product,
      // params: {
      //   "where[0][type]": "in",
      //   "where[0][attribute]": "status",
      //   "where[0][value][]": "Active",
      // },
      builder: (data) {
        List<Products> productList = [];
        Iterable i = data?['list'];
        for (var element in i) {
          productList.add(Products.fromJson(element));
        }
        return productList;
      },
    );
  }

  Future<List<Purchase>> getPurchaseList() async {
    return apiClient.callGetApi(
      endpoint: _purchase,
      builder: (data) {
        List<Purchase> purchaseList = [];
        Iterable i = data?['list'];
        for (var element in i) {
          purchaseList.add(Purchase.fromJson(element));
        }
        return purchaseList;
      },
    );
  }

  Future<PoResponse> createPO({ required Products? products}) async {
    return apiClient.callPostApi(
      endpoint: _purchaseItem,
      body: {
        "productId" : products?.id,
        "qty" : products?.reOrder,
        "qtyStock" : products?.stock,
      },
      builder: (data) {
        return PoResponse.fromJson(data);
      },
    );
  }

}
