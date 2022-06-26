import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/api/client/api_client.dart';
import 'package:neiman_inventory/app/data/models/DeliveryOrder.dart';
import 'package:neiman_inventory/app/data/models/Purchase.dart';
import 'package:neiman_inventory/app/data/models/SalesOrderItem.dart';
import 'package:neiman_inventory/app/data/remote/DeliverOrderStatusUpdateResponse.dart';
import 'package:neiman_inventory/app/data/remote/DeliveryPurchaseItem.dart';
import 'package:neiman_inventory/app/data/remote/POResponse.dart';
import 'package:neiman_inventory/app/data/remote/PostPurchaseResponse.dart';
import 'package:neiman_inventory/app/data/remote/PurchaseDetailsItem.dart';
import 'package:neiman_inventory/app/data/remote/PurchaseItem.dart';

import '../../data/models/Products.dart';
import '../../data/models/UserModel.dart';
import '../../modules/delivery_orders/controllers/delivery_orders_controller.dart';

class ApiProvider extends GetxService {
  ApiClient apiClient = Get.find();

  static const String _product = '/product';
  static const String _purchase = '/Purchase';

  static const String _deliveryPurchaseItems = '/Purchase/#/purchaseItems';
  static const String _login = '/App/user';
  static const String _purchaseItem = '/PurchaseItems';
  static const String _deliveryOrders = '/DeliveryOrders';
  static const String _deliveryPurchase = '/DeliveryPurchase';
  static const String _deliveryOrdersItems = '/Sales/#/salesOrderItems';

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

  Future<List<DeliveryPurchaseItem>> getDeliveryPurchase() async {
    return apiClient.callGET(
      endpoint: _deliveryPurchase,
      builder: (data) {
        List<DeliveryPurchaseItem> purchaseList = [];
        Iterable i = data?['list'];
        for (var element in i) {
          purchaseList.add(DeliveryPurchaseItem.fromJson(element));
        }
        return purchaseList;
      },
    );
  }

  Future<List<PurchaseDetailsItem>> getDeliveryPurchaseDetails(
      {required DeliveryPurchaseItem? deliveryPurchaseItem}) async {
    return apiClient.callGET(
      endpoint: _deliveryPurchaseItems.replaceAll(
          // "#", "${deliveryPurchaseItem?.id}"),
          "#",
          "62914641db059e0d7"),
      builder: (data) {
        List<PurchaseDetailsItem> purchaseList = [];

        Iterable i = data?['list'];
        for (var element in i) {
          purchaseList.add(PurchaseDetailsItem.fromJson(element));
        }
        return purchaseList;
      },
    );
  }

  Future<PoResponse> createPO(
      {required Products? products, required String? purchaseID}) async {
    return apiClient.callPOST(
      endpoint: _purchaseItem,
      body: {
        "productId": products?.id,
        "qty": products?.reOrder,
        "qtyStock": products?.stock,
        "purchaseId": purchaseID
      },
      builder: (data) {
        return PoResponse.fromJson(data);
      },
    );
  }

  Future<PostPurchaseResponse> postPurchase(
      {required Products? products}) async {
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

  Future<List<DeliveryOrder>> getDeliveryOrders(
      {ParentRoute? parentRoute}) async {
    return apiClient.callGET(
      endpoint: parentRoute == ParentRoute.deliveryOrders
          ? _deliveryOrders
          : _deliveryPurchase,
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

  Future<DeliveryOrder> getDeliveryOrder(
      {required DeliveryOrder? deliveryOrder,
      required ParentRoute? parentRoute}) async {
    return apiClient.callGET(
      endpoint: parentRoute == ParentRoute.deliveryOrders
          ? _deliveryOrders + "/${deliveryOrder?.id}"
          : _deliveryPurchase + "/${deliveryOrder?.purchaseId}",
      builder: (data) {
        DeliveryOrder deliveryOrder = DeliveryOrder.fromJson(data);
        return deliveryOrder;
      },
    );
  }

  Future<List<SalesOrderItem>> getDeliveryDetails(
      {required DeliveryOrder? deliveryOrder,
      required ParentRoute? parentRoute}) async {
    return apiClient.callGET(
      endpoint: parentRoute == ParentRoute.deliveryOrders
          ? _deliveryOrdersItems.replaceAll("#", "${deliveryOrder?.salesId}")
          : _deliveryPurchaseItems.replaceAll(
              "#", "${deliveryOrder?.purchaseId}"),
      //   "#",
      //   "62914641db059e0d7"),
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

  Future<List<PurchaseItem>> getPurchaseDetails(
      {required String? purchaseID}) async {
    return apiClient.callGET(
      endpoint: "/Purchase/$purchaseID/purchaseItems",
      builder: (data) {
        List<PurchaseItem> purchaseItems = [];
        Iterable i = data?['list'];
        for (var element in i) {
          purchaseItems.add(PurchaseItem.fromJson(element));
        }
        return purchaseItems;
      },
    );
  }

  Future<DeliverOrderStatusUpdateResponse> updateDeliveryStatus(
      {required String? orderStatus,
      required DeliveryOrder? deliveryOrder,
      required ParentRoute? parentRoute}) async {
    return apiClient.callPUT(
      endpoint: parentRoute == ParentRoute.deliveryOrders
          ? _deliveryOrders + "/${deliveryOrder?.id}"
          : _deliveryPurchase + "/${deliveryOrder?.purchaseId}",
      body: {"status": orderStatus},
      builder: (data) {
        DeliverOrderStatusUpdateResponse deliverOrderStatusUpdateResponse =
            DeliverOrderStatusUpdateResponse.fromJson(data);
        return deliverOrderStatusUpdateResponse;
      },
    );
  }
}
