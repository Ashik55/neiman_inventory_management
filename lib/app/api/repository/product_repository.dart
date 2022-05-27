import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/api/provider/localdb_provider.dart';
import 'package:neiman_inventory/app/data/models/Purchase.dart';
import 'package:neiman_inventory/app/data/remote/PostPurchaseResponse.dart';

import '../../data/models/DeliveryOrder.dart';
import '../../data/models/Products.dart';
import '../../data/models/SalesOrderItem.dart';
import '../../data/models/UserModel.dart';
import '../../data/remote/DeliverOrderStatusUpdateResponse.dart';
import '../../data/remote/POResponse.dart';
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

  Future<PoResponse> createPO({required Products? products,required String? purchaseID }) async {
    return _apiProvider.createPO(products: products, purchaseID: purchaseID);
  }

  Future<PostPurchaseResponse> postPurchase({required Products? products}) async {
    return _apiProvider.postPurchase(products: products);
  }

  Future<List<DeliveryOrder>> getDeliveryOrders() async {
    return _apiProvider.getDeliveryOrders();
  }

  Future<List<SalesOrderItem>> getDeliveryDetails(
      {required String? salesId}) async {
    return _apiProvider.getDeliveryDetails(salesId: salesId);
  }

  Future<DeliverOrderStatusUpdateResponse> updateDeliveryStatus(
      {required String? orderID, required String? orderStatus}) async {
    return _apiProvider.updateDeliveryStatus(
        orderID: orderID, orderStatus: orderStatus);
  }

  Future<DeliveryOrder> getDeliveryOrder({required String? orderID}) async {
    return _apiProvider.getDeliveryOrder(orderID: orderID);
  }


}
