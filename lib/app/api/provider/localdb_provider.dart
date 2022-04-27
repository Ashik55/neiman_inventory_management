import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/api/client/api_client.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/models/Products.dart';
import '../../data/models/UserModel.dart';
import '../client/db_client.dart';

class LocalDBProvider extends GetxService {
  final DBClient _dbClient = Get.find();

  Future<int> insertProduct(Products products) {
    return _dbClient.db.insert(
      'product',
      products.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteProduct(Products products) {
    return _dbClient.db.delete(
      'product',
      where: 'id = ?',
      // where: 'id = ? AND lastName = ?',
      whereArgs: [products.id],
    );
  }

  Future<List<Products>> getAllProducts() async {
    final queryResult = await _dbClient.db.query(
      'product',
      orderBy: "itemNumber ASC",
    );
    return queryResult.map((e) => Products.fromJson(e)).toList();
  }

  Future<List<Products>> searchProduct({String? searchText}) async {
    List<Map<String, Object?>> queryResult;

    final splitted = searchText?.split(' ');

    if (splitted?.length == 1) {
      queryResult = await _dbClient.db.query("product",
          where: "name LIKE ? OR barcode LIKE ? OR itemNumber LIKE ?",
          whereArgs: ['%${splitted?[0]}%', '%$searchText%', '%$searchText%']);
    } else if (splitted?.length == 2) {
      queryResult = await _dbClient.db.query("product",
          where:
              "name LIKE ? AND name LIKE ? OR barcode LIKE ? OR itemNumber LIKE ?",
          whereArgs: [
            '%${splitted?[0]}%',
            '%${splitted?[1]}%',
            '%$searchText%',
            '%$searchText%'
          ]);
    } else {
      queryResult = await _dbClient.db.query("product",
          where:
              "name LIKE ? AND name LIKE ? AND name LIKE ? OR barcode LIKE ? OR itemNumber LIKE ?",
          whereArgs: [
            '%${splitted?[0]}%',
            '%${splitted?[1]}%',
            '%${splitted?[2]}%',
            '%$searchText%',
            '%$searchText%'
          ]);
    }

    final result = queryResult;

    return result.map((e) => Products.fromJson(e)).toList();
  }

  Future<List<Products>> getFilterProductV3({String? sortBy}) async {
    List<Map<String, Object?>> queryResult = [];

    queryResult = await _dbClient.db
        .query('product', orderBy: "${sortBy ?? "itemNumber"} ASC");
    final result = queryResult;
    if (kDebugMode) {
      print("result");
      print(queryResult);
    }

    return result.map((e) => Products.fromJson(e)).toList();
  }
}
