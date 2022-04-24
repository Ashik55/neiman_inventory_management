import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/utils/constants.dart';
import '../data/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final LocalStorage _localStorage = Get.find();
  late final http.Client _httpClient;

  Future<ApiClient> init() async {
    _httpClient = http.Client();
    return this;
  }

  Future<T> callGetApi<T>({
    required String endpoint,
    Map<String, dynamic>? params,
    required T Function(Map<String, dynamic>? data) builder,
  }) async {
    print(_localStorage.getUserName());
    print(_localStorage.getPassword());

    final customEndpoint =
        "/api/v1${_localStorage.getIsCustomer() == true ? "/portal-access/625f0528806e5d1b6" : ""}$endpoint"
            .trim();

    if (kDebugMode) {
      print("End-point : $customEndpoint");
      if (params != null) print("params : ${json.encode(params)}");
    }

    var uri = Uri.https(baseUrl, customEndpoint, params);
    final response = await _httpClient.get(uri, headers: <String, String>{
      'authorization': 'Basic ' +
          base64Encode(utf8.encode(
              '${_localStorage.getUserName()}:${_localStorage.getPassword()}'))
    });
    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode != 200) {
      //post log

      if (kDebugMode) {
        print("error posting");
      }
      var errorUri = Uri.https(baseUrl, applog);
      final errorResponse = await _httpClient.post(errorUri,
          headers: <String, String>{
            'authorization': 'Basic ' +
                base64Encode(utf8.encode(
                    '${_localStorage.getUserName()}:${_localStorage.getPassword()}')),
            "Content-Type": "application/json"
          },
          body: json.encode({
            "name": customEndpoint,
            "body": json.encode(params),
            "desc": response.body.toString()
          }));
      if (kDebugMode) {
        print(errorResponse.body);
      }
    }

    if (kDebugMode) {
      print("response");
      print(response.body);
    }

    final decodedValue =
        response.body.isNotEmpty ? json.decode(response.body) : null;

    return builder(decodedValue);
  }

  Future<T> callPostApi<T>({
    required String endpoint,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    required T Function(Map<String, dynamic> data) builder,
  }) async {
    if (kDebugMode) {
      print(_localStorage.getUserName());
      print(_localStorage.getPassword());
    }

    final customEndpoint =
        "/api/v1${_localStorage.getIsCustomer() == true ? "/portal-access/625f0528806e5d1b6" : ""}$endpoint"
            .trim();

    if (kDebugMode) {
      print("End-point : $customEndpoint");
      print("Body : ${json.encode(body)}");
      if (params != null) print("params : ${json.encode(params)}");
    }

    var uri = Uri.https(baseUrl, customEndpoint, params);
    final response = await _httpClient.post(uri,
        headers: <String, String>{
          'authorization': 'Basic ' +
              base64Encode(utf8.encode(
                  '${_localStorage.getUserName()}:${_localStorage.getPassword()}')),
          "Content-Type": "application/json"
        },
        body: json.encode(body));
    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode != 200) {
      //post log
      if (kDebugMode) {
        print("error posting");
      }
      var errorUri = Uri.https(baseUrl, applog);
      final errorResponse = await _httpClient.post(errorUri,
          headers: <String, String>{
            'authorization': 'Basic ' +
                base64Encode(utf8.encode(
                    '${_localStorage.getUserName()}:${_localStorage.getPassword()}')),
            "Content-Type": "application/json"
          },
          body: json.encode({
            "name": customEndpoint,
            "body": json.encode(body),
            "desc": response.body.toString()
          }));
      if (kDebugMode) {
        print(errorResponse.body);
      }
    }

    return builder(json.decode(response.body));
  }
}
