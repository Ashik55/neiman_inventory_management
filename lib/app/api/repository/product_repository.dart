import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/api/provider/localdb_provider.dart';

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
      // final products = Products(
      //   id: element.id,
      //   name: element.name,
      //   deleted: element.deleted,
      //   description: element.description,
      //   createdAt: element.createdAt,
      //   modifiedAt: element.modifiedAt,
      //   itemNumber: element.itemNumber,
      //   barcode: element.barcode,
      //   quickbookId: element.quickbookId,
      //   locationSellable: element.locationSellable,
      //   packingOrder: element.packingOrder,
      //   passover: element.passover,
      //   status: element.status,
      //   cost: element.cost,
      //   salesPrice: element.salesPrice,
      //   qty: element.qty,
      //   quantity: 1.0,
      //   salesCount: element.salesCount,
      //   uom: element.uom,
      //   qtyUom: element.qtyUom,
      //   costCurrency: element.costCurrency,
      //   salesPriceCurrency: element.salesPriceCurrency,
      //   createdById: element.createdById,
      //   createdByName: element.createdByName,
      //   modifiedById: element.modifiedById,
      //   modifiedByName: element.modifiedByName,
      //   assignedUserId: element.assignedUserId,
      //   assignedUserName: element.assignedUserName,
      //   pictureId: element.pictureId,
      //   pictureName: element.pictureName,
      //   brandId: element.brandId,
      //   brandName: element.brandName,
      //   categoryId: element.categoryId,
      //   categoryName: element.categoryName,
      //   costConverted: element.costConverted,
      //   salesPriceConverted: element.salesPriceConverted,
      //   deliveryOrderItemsId: element.deliveryOrderItemsId,
      //   deliveryOrderItemsName: element.deliveryOrderItemsName,
      // );

    }
    return getLocalProducts();
  }

  Future<List<Products>> getLocalProducts() async {
    return _localDBProvider.getAllProducts();
  }

  Future<List<Products>> searchProduct({String? searchText}) async {
    return _localDBProvider.searchProduct(searchText: searchText);
  }


  Future<List<Products>> getFilterProductV3(
      {String? sortBy}) async {
    return _localDBProvider.getFilterProductV3(
        sortBy: sortBy);

  }


}
