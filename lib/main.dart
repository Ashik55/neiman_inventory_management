import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neiman_inventory/app/api/client/db_client.dart';
import 'package:neiman_inventory/app/api/provider/api_provider.dart';
import 'package:neiman_inventory/app/api/repository/product_repository.dart';

import 'app/api/client/api_client.dart';
import 'app/api/provider/localdb_provider.dart';
import 'app/data/local_storage/local_storage.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/colors.dart';
import 'app/utils/utility.dart';

void main() async {
  //firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  //dependancy Injection
  await GetStorage.init();
  Get.put<LocalStorage>(LocalStorage());
  await Get.putAsync<DBClient>(() => DBClient().init());
  await Get.putAsync<ApiClient>(() => ApiClient().init());
  await Get.putAsync<ApiProvider>(() async => ApiProvider());
  await Get.putAsync<LocalDBProvider>(() async => LocalDBProvider());
  await Get.putAsync<ProductRepository>(() async => ProductRepository());

  await runZonedGuarded(() async {
    runApp(MyApp());
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: createMaterialColor(CustomColors.KPrimaryColor),
        // textTheme: GoogleFonts.latoTextTheme(
        //   Theme.of(context).textTheme,
        // ),
      ),
      title: "Neiman Inventory",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      defaultTransition: Transition.rightToLeft,
    );
  }
}
