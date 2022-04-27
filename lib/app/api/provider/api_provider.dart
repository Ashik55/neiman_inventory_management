
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/api/client/api_client.dart';

import '../../data/models/Products.dart';
import '../../data/models/UserModel.dart';




class ApiProvider extends GetxService{
  ApiClient apiClient = Get.find();


  static const String _product = '/product';
  static const String _order_history = '/SalesOrderItems';
  static const String _brand = '/brand';
  static const String _category = '/category';

  // static const String _sales = '/sales';
  static const String _sales = '/sales';
  static const String _salesOrderItems = '/salesOrderItems';
  static const String _account = '/account';
  static const String _applog = '/Applog';
  static const String _login = '/App/user';



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





}