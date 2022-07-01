import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/api/provider/localdb_provider.dart';
import 'package:neiman_inventory/app/data/models/Purchase.dart';
import 'package:neiman_inventory/app/data/remote/PostPurchaseResponse.dart';
import 'package:neiman_inventory/app/modules/delivery_orders/controllers/delivery_orders_controller.dart';

import '../../data/models/BinModel.dart';
import '../../data/models/DeliveryOrder.dart';
import '../../data/models/Products.dart';
import '../../data/models/SalesOrderItem.dart';
import '../../data/models/UserModel.dart';
import '../../data/remote/BinItemModel.dart';
import '../../data/remote/DeliverOrderStatusUpdateResponse.dart';
import '../../data/remote/DeliveryPurchaseItem.dart';
import '../../data/remote/POResponse.dart';
import '../../data/remote/PurchaseDetailsItem.dart';
import '../../data/remote/PurchaseItem.dart';
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

  Future<PoResponse> createPO(
      {required Products? products, required String? purchaseID}) async {
    return _apiProvider.createPO(products: products, purchaseID: purchaseID);
  }

  Future<PostPurchaseResponse> postPurchase(
      {required Products? products}) async {
    return _apiProvider.postPurchase(products: products);
  }

  Future<List<DeliveryOrder>> getDeliveryOrders(
      {ParentRoute? parentRoute}) async {
    return _apiProvider.getDeliveryOrders(parentRoute: parentRoute);
  }

  Future<List<SalesOrderItem>> getDeliveryDetails(
      {required DeliveryOrder? deliveryOrder,
      required ParentRoute? parentRoute}) async {
    return _apiProvider.getDeliveryDetails(
        deliveryOrder: deliveryOrder, parentRoute: parentRoute);
  }

  Future<List<BinItemModel>> getBinItems({required String? productID}) async {
    return _apiProvider.getBinItems(productID: productID);
  }

  Future<List<BinModel>> getBinList() async {
    return _apiProvider.getBinList();
  }

  Future<String> addBinItem(
      {required String? productID,
      required String? binID,
      required String? qty}) async {
    return _apiProvider.addBinItem(
        productID: productID, binID: binID, qty: qty);
  }

  Future<List<PurchaseItem>> getPurchaseDetails(
      {required String? purchaseID}) async {
    return _apiProvider.getPurchaseDetails(purchaseID: purchaseID);
  }

  Future<DeliverOrderStatusUpdateResponse> updateDeliveryStatus(
      {required String? orderStatus,
      required DeliveryOrder? deliveryOrder,
      required ParentRoute? parentRoute}) async {
    return _apiProvider.updateDeliveryStatus(
        orderStatus: orderStatus,
        deliveryOrder: deliveryOrder,
        parentRoute: parentRoute);
  }

  Future<DeliveryOrder> getDeliveryOrder(
      {required DeliveryOrder? deliveryOrder,
      required ParentRoute? parentRoute}) async {
    return _apiProvider.getDeliveryOrder(
        deliveryOrder: deliveryOrder, parentRoute: parentRoute);
  }
}
