import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/utils/constants.dart';
import 'package:sqflite/sqflite.dart';
import '../../data/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class DBClient {
  late final Database db;

  Future<DBClient> init() async {
    final aux = DBClient();
    await aux.setupDB();
    return aux;
  }

  Future<void> setupDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'neiman.db');
    db = await openDatabase(path, version: 2,
        onCreate: (Database newDb, int version) async {
      //create product table
      await newDb.execute('''
          CREATE TABLE product
          (
            id TEXT PRIMARY KEY,
            name TEXT,
            deleted TEXT,
            description TEXT,
            createdAt TEXT,
            modifiedAt TEXT,
            itemNumber TEXT,
            barcode TEXT,
            quickbookId TEXT,
            locationSellable TEXT,
            packingOrder TEXT,
            passover TEXT,
            status TEXT,
            cost DOUBLE,
            salesPrice DOUBLE,
            quantity DOUBLE,
            qty DOUBLE,
            salesCount DOUBLE,
            uom TEXT,
            qtyUom TEXT,
            costCurrency TEXT,
            salesPriceCurrency TEXT,
            createdById TEXT,
            createdByName TEXT,
            modifiedById TEXT,
            modifiedByName TEXT,
            pictureName TEXT,
            pictureId TEXT,
            brandId TEXT,
            brandName TEXT,
            categoryId TEXT,
            categoryName TEXT,
            costConverted DOUBLE,
            salesPriceConverted DOUBLE
          )
        ''');

      //create product order hsitory table
      await newDb.execute('''
          CREATE TABLE order_history
          (
            id TEXT PRIMARY KEY,
            qty DOUBLE,
            delivered INT,
            unitPrice DOUBLE,
            totalPrice DOUBLE,
            createdAt TEXT,
            productId TEXT,
            customerId TEXT
          )
        ''');

      //create cart table
      await newDb.execute('''
          CREATE TABLE cart
          (
            cart_id INTEGER PRIMARY KEY AUTOINCREMENT,
            id TEXT,
            customer_id TEXT,
            name TEXT,
            deleted TEXT,
            description TEXT,
            createdAt TEXT,
            modifiedAt TEXT,
            itemNumber TEXT,
            barcode TEXT,
            quickbookId TEXT,
            locationSellable TEXT,
            packingOrder TEXT,
            passover TEXT,
            status TEXT,
            cost DOUBLE,
            salesPrice DOUBLE,
            quantity DOUBLE,
            qty DOUBLE,
            salesCount DOUBLE,
            uom TEXT,
            qtyUom TEXT,
            costCurrency TEXT,
            salesPriceCurrency TEXT,
            createdById TEXT,
            createdByName TEXT,
            modifiedById TEXT,
            modifiedByName TEXT,
            pictureName TEXT,
            pictureId TEXT,
            brandId TEXT,
            brandName TEXT,
            categoryId TEXT,
            categoryName TEXT,
            costConverted DOUBLE,
            salesPriceConverted DOUBLE
          )
        ''');
      //create brand table
      await newDb.execute('''
          CREATE TABLE brand
          (
            id TEXT PRIMARY KEY,
            name TEXT,
            deleted TEXT,
            createdById TEXT,
            createdByName TEXT
          )
        ''');
      //create category table
      await newDb.execute('''
          CREATE TABLE category
          (
            id TEXT PRIMARY KEY,
            name TEXT,
            deleted TEXT,
            createdById TEXT,
            createdByName TEXT
          )
        ''');

      //create customer table
      await newDb.execute('''
          CREATE TABLE customer
          (
            id TEXT PRIMARY KEY,
            name TEXT,
            emailAddress TEXT,
            phoneNumber TEXT,
            billingAddressStreet TEXT,
            billingAddressCity TEXT,
            billingAddressPostalCode TEXT
          )
        ''');

      //create orders table
      //must focus syntax comma after column name & no comma atlast column
      await newDb.execute('''
          CREATE TABLE sales
          (
            id TEXT PRIMARY KEY,
            qbso TEXT,
            so TEXT,
            name TEXT,
            description TEXT,
            createdAt TEXT,
            status TEXT,
            totalAmount DOUBLE,
            accountName TEXT,
            accountId TEXT,
            submitted TEXT
          )
        ''');

      await newDb.execute('''
          CREATE TABLE sales_items
          (
            id TEXT PRIMARY KEY,
            name TEXT,
            createdAt TEXT,
            qty DOUBLE,
            delivered TEXT,
            unitPrice DOUBLE,
            totalPrice DOUBLE,
            productId TEXT,
            salesId TEXT
          )
        ''');
    });
  }

}
