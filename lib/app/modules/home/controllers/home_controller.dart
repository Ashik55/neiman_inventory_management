import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();

    FirebaseCrashlytics.instance.crash();
    throw "This is a crash!";
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;
}
