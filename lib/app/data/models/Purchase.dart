class Purchase {
  Purchase({
    this.id,
    this.name,
    this.deleted,
    this.description,
    this.createdAt,
    this.modifiedAt,
    this.qty,
    this.status,
    this.qtyReceived,
    this.poNumber,
    this.createdById,
    this.createdByName,
    this.modifiedById,
    this.modifiedByName,
    this.assignedUserId,
    this.assignedUserName,
    this.productId,
    this.productName,
    this.vendorId,
    this.vendorName,
  });

  Purchase.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    deleted = json['deleted'];
    description = json['description'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
    qty = json['qty'];
    status = json['status'];
    qtyReceived = json['qtyReceived'];
    poNumber = json['poNumber'];
    createdById = json['createdById'];
    createdByName = json['createdByName'];
    modifiedById = json['modifiedById'];
    modifiedByName = json['modifiedByName'];
    assignedUserId = json['assignedUserId'];
    assignedUserName = json['assignedUserName'];
    productId = json['productId'];
    productName = json['productName'];
    vendorId = json['vendorId'];
    vendorName = json['vendorName'];
  }

  String? id;
  String? name;
  bool? deleted;
  String? description;
  String? createdAt;
  String? modifiedAt;
  num? qty;
  String? status;
  num? qtyReceived;
  String? poNumber;
  String? createdById;
  String? createdByName;
  String? modifiedById;
  String? modifiedByName;
  String? assignedUserId;
  String? assignedUserName;
  String? productId;
  String? productName;
  String? vendorId;
  String? vendorName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['deleted'] = deleted;
    map['description'] = description;
    map['createdAt'] = createdAt;
    map['modifiedAt'] = modifiedAt;
    map['qty'] = qty;
    map['status'] = status;
    map['qtyReceived'] = qtyReceived;
    map['poNumber'] = poNumber;
    map['createdById'] = createdById;
    map['createdByName'] = createdByName;
    map['modifiedById'] = modifiedById;
    map['modifiedByName'] = modifiedByName;
    map['assignedUserId'] = assignedUserId;
    map['assignedUserName'] = assignedUserName;
    map['productId'] = productId;
    map['productName'] = productName;
    map['vendorId'] = vendorId;
    map['vendorName'] = vendorName;
    return map;
  }
}
