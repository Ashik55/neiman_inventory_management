import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:neiman_inventory/app/modules/base/base_view.dart';

import '../../../data/models/Products.dart';
import '../../../utils/dimens.dart';
import '../../../utils/utility.dart';
import '../../components/custom_textwidget.dart';
import '../../components/grid_product_item.dart';
import '../../components/load_image.dart';
import '../../components/product_item.dart';
import '../../home/views/home_view.dart';
import '../controllers/purchase_create_controller.dart';

class PurchaseCreateView extends GetView<PurchaseCreateController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseCreateController>(
        builder: (controller) => Scaffold(
            appBar: AppBar(
              title: CText(
                'Create Purchase',
                fontSize: Dimens.appbarTextSize,
                textColor: Colors.white,
              ),
            ),
            body: BaseView(
              showLoading: controller.loading,
              child: Column(
                children: [
                  Container(
                    // color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimens.basePaddingNone,
                        horizontal: Dimens.basePaddingNone),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller.searchController,
                              onChanged: (e) => controller.onSearchChange(e),
                              decoration: InputDecoration(
                                labelText: 'Search Products',
                                border: const OutlineInputBorder(),
                                prefixIcon: const Icon(
                                  Icons.search,
                                ),
                                suffixIcon:
                                    controller.searchController.text.isNotEmpty
                                        ? IconButton(
                                            onPressed: () =>
                                                controller.clearSearch(),
                                            icon: const Icon(Icons.clear),
                                          )
                                        : null,
                              ),
                            ),
                          ),
                          const SizedBox(width: 18),
                          InkWell(
                              onTap: () => controller.openBarCodeScanner(),
                              child: CAssetImage(
                                imagePath: 'images/barcode.png',
                                height: 40,
                              ))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: controller.productList.isEmpty == true
                          ? NoDataWidget(
                              isLoading: controller.loading,
                            )
                          : ListView.builder(
                              itemCount: controller.productList.length,
                              padding: const EdgeInsets.only(bottom: 5),
                              shrinkWrap: true,
                              // physics: BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) =>
                                  PurchaseProductItem(
                                products: controller.productList[index],
                                onclick: (Products? products) => controller
                                    .onProductClick(products: products),
                                onStockUpdate: (Products? products) {},
                                onReorderUpdate: (Products? products) {},
                                    onSubmitUpdate: (Products? products) => controller.onPOSubmit(products),
                              ),
                            )),
                ],
              ),
            )));
  }
}
