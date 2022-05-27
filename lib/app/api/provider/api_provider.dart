import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/api/client/api_client.dart';
import 'package:neiman_inventory/app/data/models/DeliveryOrder.dart';
import 'package:neiman_inventory/app/data/models/Purchase.dart';
import 'package:neiman_inventory/app/data/models/SalesOrderItem.dart';
import 'package:neiman_inventory/app/data/remote/DeliverOrderStatusUpdateResponse.dart';
import 'package:neiman_inventory/app/data/remote/POResponse.dart';
import 'package:neiman_inventory/app/data/remote/PostPurchaseResponse.dart';

import '../../data/models/Products.dart';
import '../../data/models/UserModel.dart';

class ApiProvider extends GetxService {
  ApiClient apiClient = Get.find();

  static const String _product = '/product';
  static const String _purchase = '/Purchase';
  static const String _login = '/App/user';
  static const String _purchaseItem = '/PurchaseItems';
  static const String _deliveryOrders = '/DeliveryOrders';

  // static const String _deliveryDetails = '/Sales/627a9cf6628dabd85/salesOrderItems';

  Future<UserModel?> loginNow() async {
    return apiClient.callGET(
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
    return apiClient.callGET(
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
    return apiClient.callGET(
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

  Future<PoResponse> createPO({required Products? products}) async {
    return apiClient.callPOST(
      endpoint: _purchaseItem,
      body: {
        "productId": products?.id,
        "qty": products?.reOrder,
        "qtyStock": products?.stock,
      },
      builder: (data) {
        return PoResponse.fromJson(data);
      },
    );
  }

  Future<PostPurchaseResponse> postPurchase({required Products? products}) async {
    return apiClient.callPOST(
      endpoint: _purchase,
      body: {
        "name": products?.vendorName,
        "status": "Quotation",
        "qbVendorID": products?.vendorID,
      },
      builder: (data) {
        return PostPurchaseResponse.fromJson(data);
      },
    );
  }




  Future<List<DeliveryOrder>> getDeliveryOrders() async {
    return apiClient.callGET(
      endpoint: _deliveryOrders,
      builder: (data) {
        List<DeliveryOrder> deliveryOrders = [];
        Iterable i = data?['list'];
        for (var element in i) {
          deliveryOrders.add(DeliveryOrder.fromJson(element));
        }
        return deliveryOrders;
      },
    );
  }

  Future<DeliveryOrder> getDeliveryOrder({required String? orderID}) async {
    return apiClient.callGET(
      endpoint: _deliveryOrders+"/$orderID",
      builder: (data) {
        DeliveryOrder deliveryOrder = DeliveryOrder.fromJson(data);
        return deliveryOrder;
      },
    );
  }

  Future<List<SalesOrderItem>> getDeliveryDetails(
      {required String? salesId}) async {
    return apiClient.callGET(
      endpoint: "/Sales/$salesId/salesOrderItems",
      builder: (data) {
        List<SalesOrderItem> salesOrderItems = [];
        Iterable i = data?['list'];
        for (var element in i) {
          salesOrderItems.add(SalesOrderItem.fromJson(element));
        }
        return salesOrderItems;
      },
    );
  }

  Future<DeliverOrderStatusUpdateResponse> updateDeliveryStatus(
      {required String? orderID, required String? orderStatus}) async {
    return apiClient.callPUT(
      endpoint: "/DeliveryOrders/$orderID",
      body: {"status": orderStatus},
      builder: (data) {
        DeliverOrderStatusUpdateResponse deliverOrderStatusUpdateResponse =
            DeliverOrderStatusUpdateResponse.fromJson(data);
        return deliverOrderStatusUpdateResponse;
      },
    );
  }
}
