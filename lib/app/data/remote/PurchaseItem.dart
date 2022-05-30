class PurchaseItem {
  PurchaseItem({
      this.id, 
      this.name, 
      this.deleted, 
      this.description, 
      this.createdAt, 
      this.modifiedAt, 
      this.qty, 
      this.qtyStock, 
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

  PurchaseItem.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    deleted = json['deleted'];
    description = json['description'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
    qty = json['qty'];
    qtyStock = json['qtyStock'];
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
  dynamic name;
  bool? deleted;
  dynamic description;
  String? createdAt;
  String? modifiedAt;
  int? qty;
  int? qtyStock;
  String? createdById;
  String? createdByName;
  dynamic modifiedById;
  dynamic modifiedByName;
  dynamic assignedUserId;
  dynamic assignedUserName;
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