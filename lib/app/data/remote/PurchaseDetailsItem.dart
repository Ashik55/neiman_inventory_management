class PurchaseDetailsItem {
  PurchaseDetailsItem({
      this.id, 
      this.name, 
      this.deleted, 
      this.description, 
      this.createdAt, 
      this.modifiedAt, 
      this.qty, 
      this.qtyStock, 
      this.itemsNumber, 
      this.barcode, 
      this.createdById, 
      this.createdByName, 
      this.modifiedById, 
      this.modifiedByName, 
      this.assignedUserId, 
      this.assignedUserName, 
      this.productId, 
      this.productName, 
      this.purchaseId, 
      this.purchaseName,});

  PurchaseDetailsItem.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    deleted = json['deleted'];
    description = json['description'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
    qty = json['qty'];
    qtyStock = json['qtyStock'];
    itemsNumber = json['itemsNumber'];
    barcode = json['barcode'];
    createdById = json['createdById'];
    createdByName = json['createdByName'];
    modifiedById = json['modifiedById'];
    modifiedByName = json['modifiedByName'];
    assignedUserId = json['assignedUserId'];
    assignedUserName = json['assignedUserName'];
    productId = json['productId'];
    productName = json['productName'];
    purchaseId = json['purchaseId'];
    purchaseName = json['purchaseName'];
  }
  String? id;
  String? name;
  bool? deleted;
  String? description;
  String? createdAt;
  String? modifiedAt;
  int? qty;
  String? qtyStock;
  String? itemsNumber;
  String? barcode;
  String? createdById;
  String? createdByName;
  String? modifiedById;
  String? modifiedByName;
  String? assignedUserId;
  String? assignedUserName;
  String? productId;
  String? productName;
  String? purchaseId;
  String? purchaseName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['deleted'] = deleted;
    map['description'] = description;
    map['createdAt'] = createdAt;
    map['modifiedAt'] = modifiedAt;
    map['qty'] = qty;
    map['qtyStock'] = qtyStock;
    map['itemsNumber'] = itemsNumber;
    map['barcode'] = barcode;
    map['createdById'] = createdById;
    map['createdByName'] = createdByName;
    map['modifiedById'] = modifiedById;
    map['modifiedByName'] = modifiedByName;
    map['assignedUserId'] = assignedUserId;
    map['assignedUserName'] = assignedUserName;
    map['productId'] = productId;
    map['productName'] = productName;
    map['purchaseId'] = purchaseId;
    map['purchaseName'] = purchaseName;
    return map;
  }

}