import 'package:get/get.dart';

import '../modules/delivery_details/bindings/delivery_details_binding.dart';
import '../modules/delivery_details/views/delivery_details_view.dart';
import '../modules/delivery_orders/bindings/delivery_orders_binding.dart';
import '../modules/delivery_orders/views/delivery_orders_view.dart';
import '../modules/delivery_purchase_details/bindings/delivery_purchase_details_binding.dart';
import '../modules/delivery_purchase_details/views/delivery_purchase_details_view.dart';
import '../modules/delivery_purchase_list/bindings/delivery_purchase_list_binding.dart';
import '../modules/delivery_purchase_list/views/delivery_purchase_list_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/image_preview/bindings/image_preview_binding.dart';
import '../modules/image_preview/views/image_preview_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/purchase/bindings/purchase_binding.dart';
import '../modules/purchase/views/purchase_view.dart';
import '../modules/purchase_create/bindings/purchase_create_binding.dart';
import '../modules/purchase_create/views/purchase_create_view.dart';
import '../modules/purchase_details/bindings/purchase_details_binding.dart';
import '../modules/purchase_details/views/purchase_details_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.IMAGE_PREVIEW,
      page: () => ImagePreviewView(),
      binding: ImagePreviewBinding(),
    ),
    GetPage(
      name: _Paths.PURCHASE,
      page: () => PurchaseView(),
      binding: PurchaseBinding(),
    ),
    GetPage(
      name: _Paths.PURCHASE_CREATE,
      page: () => PurchaseCreateView(),
      binding: PurchaseCreateBinding(),
    ),
    GetPage(
      name: _Paths.DELIVERY_DETAILS,
      page: () => DeliveryDetailsView(),
      binding: DeliveryDetailsBinding(),
    ),
    GetPage(
      name: _Paths.DELIVERY_ORDERS,
      page: () => DeliveryOrdersView(),
      binding: DeliveryOrdersBinding(),
    ),
    GetPage(
      name: _Paths.PURCHASE_DETAILS,
      page: () => PurchaseDetailsView(),
      binding: PurchaseDetailsBinding(),
    ),
    GetPage(
      name: _Paths.DELIVERY_PURCHASE_LIST,
      page: () => DeliveryPurchaseListView(),
      binding: DeliveryPurchaseListBinding(),
    ),
    GetPage(
      name: _Paths.DELIVERY_PURCHASE_DETAILS,
      page: () => DeliveryPurchaseDetailsView(),
      binding: DeliveryPurchaseDetailsBinding(),
    ),
  ];
}
