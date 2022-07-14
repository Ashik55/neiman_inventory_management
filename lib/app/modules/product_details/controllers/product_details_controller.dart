import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:neiman_inventory/app/data/models/title_id_model.dart';
import 'package:neiman_inventory/app/modules/base/base_controller.dart';
import 'package:neiman_inventory/app/modules/components/CDropdown.dart';
import 'package:neiman_inventory/app/modules/home/controllers/home_controller.dart';

import '../../../api/repository/product_repository.dart';
import '../../../data/local_storage/local_storage.dart';
import '../../../data/models/BinModel.dart';
import '../../../data/models/Products.dart';
import '../../../data/remote/BinItemModel.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimens.dart';
import '../../../utils/toaster.dart';
import '../../../utils/utility.dart';
import '../../components/custom_textfield.dart';
import '../../components/custom_textwidget.dart';
import '../../components/rounded_button.dart';

class ProductDetailsController extends BaseController {
  LocalStorage localStorage = Get.find();
  HomeController productController = Get.find();
  final ProductRepository _productRepository = Get.find();

  late PageController pageController;
  late int indexToShow;
  List<String> image_list = [];
  int selectedIndex = 1;
  bool showQuantity = false;
  String? listType;
  bool isSearchSelected = false;
  String? costVisibleIndex;
  List<BinItemModel> binItems = [];
  List<TitleIDModel> binIDList = [];

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      indexToShow = Get.arguments["index"];
      listType = Get.arguments["list"];
      if (listType == "search") {
        isSearchSelected = true;
      } else {
        isSearchSelected = false;
      }
      selectedIndex = indexToShow;
      print("indexToShow : $indexToShow");
      pageController = PageController(
          initialPage: indexToShow, keepPage: true, viewportFraction: 1);

      update();
    } else {
      pageController = PageController();
      update();
    }

    getBins();
    getBinItems();
  }

  getBins() async {
    startLoading();

    binIDList.clear();
    final binList = await _productRepository.getBinList();
    for (var element in binList) {
      binIDList.add(TitleIDModel(id: element.id, title: element.name));
    }

    stopLoading();
  }

  getBinItems() async {
    binItems.clear();
    binItems = await _productRepository.getBinItems(
        productID: getCurrentProduct()?.id);
    update();
  }

  Products? getCurrentProduct() {
    return productController.productList[selectedIndex];
  }

  onpageChange(int index) async {
    print(index);
    selectedIndex = index;
    await getBinItems();
  }

  onImageClick(Products? products) {
    Get.toNamed(Routes.IMAGE_PREVIEW, arguments: {
      "image": getRegularImageUrl(products?.pictureId),
    });
  }

  createBinItem({required Products? products}) {
    if (binIDList.isNotEmpty) {
      showCreateBinItemBottomSheet(
          binIDList: binIDList,
          addBinItemClick: (binID, quantity) async {
            Get.back();
            startLoading();
            String data = await _productRepository.addBinItem(
                productID: getCurrentProduct()?.id,
                binID: binID,
                qty: quantity);
            await getBinItems();
            stopLoading();
          });
    } else {
      showMessageSnackbar(message: "Sorry Bin list is empty");
    }
  }

  onBinItemClick({BinItemModel? binItemModel}) {
    TitleIDModel titleIDModel =
        TitleIDModel(id: binItemModel?.binId, title: binItemModel?.binName);

    if (binIDList.isNotEmpty) {
      showCreateBinItemBottomSheet(
          selectedBin: titleIDModel,
          quantity: "${binItemModel?.qty}",
          binIDList: binIDList,
          addBinItemClick: (binID, quantity) async {
            Get.back();
            startLoading();
            String data = await _productRepository.updateBinItem(
                binID: binItemModel?.id, qty: quantity);
            await getBinItems();
            stopLoading();
          });
    } else {
      showMessageSnackbar(message: "Sorry Bin list is empty");
    }
  }

  void showCreateBinItemBottomSheet(
      {required List<TitleIDModel> binIDList,
      TitleIDModel? selectedBin,
      String? quantity,
      required Function(
        String? binID,
        String? quantity,
      )
          addBinItemClick}) {
    String? selectedBinID = selectedBin?.id ?? binIDList.first.id;
    TextEditingController quantityController = TextEditingController();

    if (quantity != null) {
      quantityController.text = quantity;
    }

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(Dimens.radiusMid))),
      isScrollControlled: true,
      context: scaffoldKey.currentContext!,
      backgroundColor: Colors.white,
      builder: (context) => GetBuilder<ProductDetailsController>(
        builder: (controller) => Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: Dimens.basePaddingLarge),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  height: 4,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CText(
                  "Choose Bin",
                  fontWeight: FontWeight.w600,
                ),
              ),
              CDropdown(
                  itemList: binIDList,
                  isDisable: selectedBin != null,
                  strokeColor: Colors.grey,
                  selectedItem: selectedBin,
                  textColor: CustomColors.KPrimaryColor,
                  onChange: (selectedID) => selectedBinID = selectedID),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CText(
                  "Add Quantity",
                  fontWeight: FontWeight.w600,
                ),
              ),
              CTextField(
                hintText: '0',
                textInputType: TextInputType.number,
                textAlign: TextAlign.start,
                controller: quantityController,
                strokeColor: Colors.grey,
                radius: Dimens.radiusMin,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimens.basePaddingLarge),
                child: CRoundedButton(
                    text: 'Add Bin Item',
                    onClick: () {
                      if (selectedBinID != null) {
                        if (quantityController.text.isNotEmpty) {
                          addBinItemClick(
                              selectedBinID, quantityController.text);
                        } else {
                          showMessageSnackbar(
                              message: "PLease enter valid quantity");
                        }
                      } else {
                        showMessageSnackbar(message: "PLease select Bin");
                      }
                    },
                    backgroundColor: CustomColors.KPrimaryColor,
                    width: getMaxWidth(context),
                    radius: Dimens.radiusNone),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
