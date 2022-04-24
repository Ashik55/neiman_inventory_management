import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neiman_inventory/app/api/provider/api_provider.dart';
import 'package:neiman_inventory/app/api/repository/auth_repository.dart';
import 'package:neiman_inventory/app/api/repository/product_repository.dart';

import 'app/api/api_client.dart';
import 'app/data/local_storage/local_storage.dart';
import 'app/routes/app_pages.dart';

void main() async{

  //dependancy Injection
  await GetStorage.init();
  Get.put<LocalStorage>(LocalStorage());
  await Get.putAsync<ApiClient>(() => ApiClient().init());
  await Get.putAsync<ApiProvider>(() async => ApiProvider());
  await Get.putAsync<ProductRepository>(() async => ProductRepository());
  await Get.putAsync<AuthRepository>(() async => AuthRepository());


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
