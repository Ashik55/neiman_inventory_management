class BinItemModel {
  BinItemModel({
      this.id, 
      this.name, 
      this.deleted, 
      this.description, 
      this.createdAt, 
      this.modifiedAt, 
      this.qty, 
      this.createdById, 
      this.createdByName, 
      this.modifiedById, 
      this.modifiedByName, 
      this.assignedUserId, 
      this.assignedUserName, 
      this.productId, 
      this.productName, 
      this.binId, 
      this.binName,});

  BinItemModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    deleted = json['deleted'];
    description = json['description'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
    qty = json['qty'];
    createdById = json['createdById'];
    createdByName = json['createdByName'];
    modifiedById = json['modifiedById'];
    modifiedByName = json['modifiedByName'];
    assignedUserId = json['assignedUserId'];
    assignedUserName = json['assignedUserName'];
    productId = json['productId'];
    productName = json['productName'];
    binId = json['binId'];
    binName = json['binName'];
  }
  String? id;
  String? name;
  bool? deleted;
  dynamic description;
  String? createdAt;
  String? modifiedAt;
  num? qty;
  String? createdById;
  String? createdByName;
  String? modifiedById;
  String? modifiedByName;
  String? assignedUserId;
  String? assignedUserName;
  String? productId;
  String? productName;
  String? binId;
  String? binName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['deleted'] = deleted;
    map['description'] = description;
    map['createdAt'] = createdAt;
    map['modifiedAt'] = modifiedAt;
    map['qty'] = qty;
    map['createdById'] = createdById;
    map['createdByName'] = createdByName;
    map['modifiedById'] = modifiedById;
    map['modifiedByName'] = modifiedByName;
    map['assignedUserId'] = assignedUserId;
    map['assignedUserName'] = assignedUserName;
    map['productId'] = productId;
    map['productName'] = productName;
    map['binId'] = binId;
    map['binName'] = binName;
    return map;
  }

}