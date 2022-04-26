import 'dart:convert';

class Products {
  Products({
    this.id,
    this.name,
    this.deleted,
    this.description,
    this.createdAt,
    this.modifiedAt,
    this.itemNumber,
    this.barcode,
    this.quickbookId,
    this.locationSellable,
    this.packingOrder,
    this.passover,
    this.status,
    this.cost,
    this.salesPrice,
    this.qty,
    this.quantity,
    this.salesCount,
    this.uom,
    this.qtyUom,
    this.costCurrency,
    this.salesPriceCurrency,
    this.createdById,
    this.createdByName,
    this.modifiedById,
    this.modifiedByName,
    this.assignedUserId,
    this.assignedUserName,
    this.pictureId,
    this.pictureName,
    this.brandId,
    this.brandName,
    this.categoryId,
    this.categoryName,
    this.costConverted,
    this.salesPriceConverted,
    this.deliveryOrderItemsId,
    this.deliveryOrderItemsName,
  });

  Products.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    deleted = json['deleted'].toString().toLowerCase() == "true" ? true : false;
    description = json['description'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
    itemNumber = json['itemNumber'];
    barcode = json['barcode'];
    quickbookId = json['quickbookId'];

    if (json['locationSellable'].runtimeType == String) {
      Iterable iterable = jsonDecode(json['locationSellable']);
      List<String> sellable = [];
      for (var element in iterable) {
        sellable.add("$element");
      }
      locationSellable = sellable;
    } else {
      locationSellable = json['locationSellable'] != null
          ? json['locationSellable'].cast<String>()
          : [];
    }

    packingOrder = json['packingOrder'];
    passover =
        json['passover'].toString().toLowerCase() == "true" ? true : false;
    status = json['status'];
    cost = json['cost'];
    salesPrice = json['salesPrice'];
    quantity = json['quantity'];
    qty = json['qty'];
    salesCount = json['salesCount'];
    uom = json['uom'];
    qtyUom = json['qtyUom'];
    costCurrency = json['costCurrency'];
    salesPriceCurrency = json['salesPriceCurrency'];
    createdById = json['createdById'];
    createdByName = json['createdByName'];
    modifiedById = json['modifiedById'];
    modifiedByName = json['modifiedByName'];
    assignedUserId = json['assignedUserId'];
    assignedUserName = json['assignedUserName'];
    pictureId = json['pictureId'];
    pictureName = json['pictureName'];
    brandId = json['brandId'];
    brandName = json['brandName'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    costConverted = json['costConverted'];
    salesPriceConverted = json['salesPriceConverted'];
    deliveryOrderItemsId = json['deliveryOrderItemsId'];
    deliveryOrderItemsName = json['deliveryOrderItemsName'];
  }

  String? id;
  String? name;
  bool? deleted;
  String? description;
  String? createdAt;
  String? modifiedAt;
  String? itemNumber;
  String? barcode;
  String? quickbookId;
  List<String>? locationSellable;
  String? packingOrder;
  bool? passover;
  String? status;
  num? cost;
  num? salesPrice;
  double? quantity;
  num? qty;
  num? salesCount;
  String? uom;
  String? qtyUom;
  String? costCurrency;
  String? salesPriceCurrency;
  String? createdById;
  String? createdByName;
  String? modifiedById;
  String? modifiedByName;
  dynamic assignedUserId;
  dynamic assignedUserName;
  String? pictureId;
  String? pictureName;
  String? brandId;
  String? brandName;
  String? categoryId;
  String? categoryName;
  num? costConverted;
  num? salesPriceConverted;
  dynamic deliveryOrderItemsId;
  dynamic deliveryOrderItemsName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['deleted'] = deleted.toString();
    map['description'] = description;
    map['createdAt'] = createdAt;
    map['modifiedAt'] = modifiedAt;
    map['itemNumber'] = itemNumber;
    map['barcode'] = barcode;
    map['quickbookId'] = quickbookId;
    map['locationSellable'] = json.encode(locationSellable);
    map['packingOrder'] = packingOrder;
    map['passover'] = passover.toString();
    map['status'] = status;
    map['cost'] = cost;
    map['salesPrice'] = salesPrice;
    map['quantity'] = quantity;
    map['qty'] = qty;
    map['salesCount'] = salesCount;
    map['uom'] = uom;
    map['qtyUom'] = qtyUom;
    map['costCurrency'] = costCurrency;
    map['salesPriceCurrency'] = salesPriceCurrency;
    map['createdById'] = createdById;
    map['createdByName'] = createdByName;
    map['modifiedById'] = modifiedById;
    map['modifiedByName'] = modifiedByName;
    // map['assignedUserId'] = assignedUserId;
    // map['assignedUserName'] = assignedUserName;
    map['pictureId'] = pictureId;
    map['pictureName'] = pictureName;
    map['brandId'] = brandId;
    map['brandName'] = brandName;
    map['categoryId'] = categoryId;
    map['categoryName'] = categoryName;
    map['costConverted'] = costConverted;
    map['salesPriceConverted'] = salesPriceConverted;
    // map['deliveryOrderItemsId'] = deliveryOrderItemsId;
    // map['deliveryOrderItemsName'] = deliveryOrderItemsName;
    return map;
  }
}
