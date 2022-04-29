import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:neiman_inventory/app/modules/base/base_view.dart';
import 'package:neiman_inventory/app/modules/components/grid_product_item.dart';
import 'package:neiman_inventory/app/modules/components/load_image.dart';

import '../../../data/models/Products.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimens.dart';
import '../../../utils/utility.dart';
import '../../components/custom_textwidget.dart';
import '../../components/id_selectable_chip.dart';
import '../../components/product_item.dart';
import '../../components/rounded_button.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => Scaffold(
            key: controller.scaffoldKey,
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              title: CText(
                'Products',
                fontSize: Dimens.appbarTextSize,
                textColor: Colors.white,
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.filter_alt,
                    color: Colors.white,
                  ),
                  onPressed: () =>
                      controller.scaffoldKey.currentState?.openEndDrawer(),
                ),
              ],
            ),
            drawer: Drawer(
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        CText(
                          'Menus',
                          textColor: Colors.white,
                          fontSize: Dimens.textLargeDoubleExtra,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.restore_outlined),
                    title: CText('Purchase'),
                    onTap: () => controller.onPurchaseClick(),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.arrow_back,
                      color: CustomColors.KPrimaryColor,
                    ),
                    title: CText(
                      'Logout',
                      fontWeight: FontWeight.bold,
                      textColor: CustomColors.KPrimaryColor,
                    ),
                    onTap: () => controller.onLogoutClick(),
                  ),
                ],
              ),
            ),
            endDrawer: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Drawer(
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                        height: getOrientation(context) == Orientation.portrait
                            ? 25
                            : 8),
                    // Row(
                    //   children: [
                    //     const Spacer(),
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //       child: TextButton(
                    //         onPressed: () => controller.resetFilters(),
                    //         child: CText(
                    //           "Reset Filters",
                    //           textColor: Colors.red,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),

                    const SizedBox(height: 25),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.basePadding),
                      child: CText(
                        'Sort by',
                        fontSize: Dimens.textRegular,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.basePadding),
                      child: GridView(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                getOrientation(context) == Orientation.portrait
                                    ? 2
                                    : 3,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            childAspectRatio:
                                getOrientation(context) == Orientation.portrait
                                    ? 4
                                    : 6),
                        children: [
                          IdSelectableChipWidget(
                            id: "name",
                            value: "Name",
                            onSelect: (String? id) =>
                                controller.onSortBySelect(id),
                            fontSize: Dimens.textMinMid,
                            radius: Dimens.radiusMin,
                            backgroundColor: Colors.grey.shade200,
                            fontWeight: FontWeight.normal,
                            textColor: Colors.black,
                            elevation: 0,
                            isSelected: controller.sortBy == "name",
                          ),
                          IdSelectableChipWidget(
                            id: "itemNumber",
                            value: "Item Number",
                            onSelect: (String? id) =>
                                controller.onSortBySelect(id),
                            fontSize: Dimens.textMinMid,
                            radius: Dimens.radiusMin,
                            backgroundColor: Colors.grey.shade200,
                            fontWeight: FontWeight.normal,
                            textColor: Colors.black,
                            elevation: 0,
                            isSelected: controller.sortBy == "itemNumber",
                          ),
                          IdSelectableChipWidget(
                            id: "salesCount",
                            value: "Sold Rank",
                            onSelect: (String? id) =>
                                controller.onSortBySelect(id),
                            fontSize: Dimens.textMinMid,
                            radius: Dimens.radiusMin,
                            backgroundColor: Colors.grey.shade200,
                            fontWeight: FontWeight.normal,
                            textColor: Colors.black,
                            elevation: 0,
                            isSelected: controller.sortBy == "salesCount",
                          ),
                          IdSelectableChipWidget(
                            id: "qty",
                            value: "Quantity",
                            onSelect: (String? id) =>
                                controller.onSortBySelect(id),
                            fontSize: Dimens.textMinMid,
                            radius: Dimens.radiusMin,
                            backgroundColor: Colors.grey.shade200,
                            fontWeight: FontWeight.normal,
                            textColor: Colors.black,
                            elevation: 0,
                            isSelected: controller.sortBy == "qty",
                          ),
                          IdSelectableChipWidget(
                            id: "salesPrice",
                            value: "Sales Price",
                            onSelect: (String? id) =>
                                controller.onSortBySelect(id),
                            fontSize: Dimens.textMinMid,
                            radius: Dimens.radiusMin,
                            backgroundColor: Colors.grey.shade200,
                            fontWeight: FontWeight.normal,
                            textColor: Colors.black,
                            elevation: 0,
                            isSelected: controller.sortBy == "salesPrice",
                          ),
                          IdSelectableChipWidget(
                            id: "categoryName",
                            value: "Category Name",
                            onSelect: (String? id) =>
                                controller.onSortBySelect(id),
                            fontSize: Dimens.textMinMid,
                            radius: Dimens.radiusMin,
                            backgroundColor: Colors.grey.shade200,
                            fontWeight: FontWeight.normal,
                            textColor: Colors.black,
                            elevation: 0,
                            isSelected: controller.sortBy == "categoryName",
                          ),
                          IdSelectableChipWidget(
                            id: "brandName",
                            value: "Brand Name",
                            onSelect: (String? id) =>
                                controller.onSortBySelect(id),
                            fontSize: Dimens.textMinMid,
                            radius: Dimens.radiusMin,
                            backgroundColor: Colors.grey.shade200,
                            fontWeight: FontWeight.normal,
                            textColor: Colors.black,
                            elevation: 0,
                            isSelected: controller.sortBy == "brandName",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
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
                          :

                          // ListView.builder(
                          GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: getOrientation(context) ==
                                              Orientation.portrait
                                          ? 2
                                          : 3,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                      childAspectRatio:
                                          getOrientation(context) ==
                                                  Orientation.portrait
                                              ? .75
                                              : 1.3),

                              // crossAxisCount: 2,
                              // mainAxisSpacing: 2,
                              // crossAxisSpacing: 2,
                              // childAspectRatio: .75),
                              itemCount: controller.productList.length,
                              padding: const EdgeInsets.only(bottom: 5),
                              shrinkWrap: true,
                              // physics: BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) =>
                                  GridProductItem(
                                products: controller.productList[index],
                                onclick: (Products? products) => controller
                                    .onProductClick(products: products),
                              ),
                            )),
                ],
              ),
            )));
  }
}

class NoDataWidget extends StatelessWidget {
  bool? isLoading;
  String? dataName;

  NoDataWidget({this.isLoading, this.dataName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CText(
          isLoading == true ? "Please Wait . . " : "No data found"),
    );
  }
}
