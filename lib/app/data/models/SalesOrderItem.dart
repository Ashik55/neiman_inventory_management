class SalesOrderItem {
  SalesOrderItem({
    this.id,
    this.name,
    this.deleted,
    this.description,
    this.createdAt,
    this.modifiedAt,
    this.qty,
    this.delivered,
    this.unitPrice,
    this.totalPrice,
    this.qbProductId,
    this.done,
    this.packingOrder,
    this.unitPriceCurrency,
    this.totalPriceCurrency,
    this.createdById,
    this.createdByName,
    this.modifiedById,
    this.barcode,
    this.modifiedByName,
    this.assignedUserId,
    this.assignedUserName,
    this.unitPriceConverted,
    this.totalPriceConverted,
    this.productId,
    this.productName,
    this.salesId,
    this.salesName,
    this.accountId,
    this.accountName,
  });

  SalesOrderItem.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    deleted = json['deleted'];
    description = json['description'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
    qty = json['qty'];
    delivered = json['delivered'];
    unitPrice = json['unitPrice'];
    totalPrice = json['totalPrice'];
    qbProductId = json['qbProductId'];
    done = json['done'];
    barcode = json['barcode'];
    packingOrder = json['packingOrder'];
    unitPriceCurrency = json['unitPriceCurrency'];
    totalPriceCurrency = json['totalPriceCurrency'];
    createdById = json['createdById'];
    createdByName = json['createdByName'];
    modifiedById = json['modifiedById'];
    modifiedByName = json['modifiedByName'];
    assignedUserId = json['assignedUserId'];
    assignedUserName = json['assignedUserName'];
    unitPriceConverted = json['unitPriceConverted'];
    totalPriceConverted = json['totalPriceConverted'];
    productId = json['productId'];
    productName = json['productName'];
    salesId = json['salesId'];
    salesName = json['salesName'];
    accountId = json['accountId'];
    accountName = json['accountName'];
  }

  String? id;
  String? name;
  bool? deleted;
  dynamic description;
  String? createdAt;
  String? modifiedAt;
  int? qty;
  int? delivered;
  num? unitPrice;
  num? totalPrice;
  String? qbProductId;
  bool? done;
  String? packingOrder;
  String? barcode;
  String? unitPriceCurrency;
  String? totalPriceCurrency;
  String? createdById;
  String? createdByName;
  dynamic modifiedById;
  dynamic modifiedByName;
  dynamic assignedUserId;
  dynamic assignedUserName;
  num? unitPriceConverted;
  num? totalPriceConverted;
  String? productId;
  String? productName;
  String? salesId;
  String? salesName;
  String? accountId;
  String? accountName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['deleted'] = deleted;
    map['description'] = description;
    map['createdAt'] = createdAt;
    map['modifiedAt'] = modifiedAt;
    map['qty'] = qty;
    map['delivered'] = delivered;
    map['unitPrice'] = unitPrice;
    map['totalPrice'] = totalPrice;
    map['qbProductId'] = qbProductId;
    map['done'] = done;
    map['packingOrder'] = packingOrder;
    map['unitPriceCurrency'] = unitPriceCurrency;
    map['totalPriceCurrency'] = totalPriceCurrency;
    map['createdById'] = createdById;
    map['createdByName'] = createdByName;
    map['modifiedById'] = modifiedById;
    map['modifiedByName'] = modifiedByName;
    map['assignedUserId'] = assignedUserId;
    map['assignedUserName'] = assignedUserName;
    map['unitPriceConverted'] = unitPriceConverted;
    map['totalPriceConverted'] = totalPriceConverted;
    map['productId'] = productId;
    map['productName'] = productName;
    map['salesId'] = salesId;
    map['salesName'] = salesName;
    map['accountId'] = accountId;
    map['accountName'] = accountName;
    return map;
  }
}
