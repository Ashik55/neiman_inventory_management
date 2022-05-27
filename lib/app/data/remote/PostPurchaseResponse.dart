class PostPurchaseResponse {
  PostPurchaseResponse({
      this.id, 
      this.name, 
      this.deleted, 
      this.createdAt, 
      this.modifiedAt, 
      this.status, 
      this.poNumber, 
      this.qbVendorID, 
      this.createdById,});

  PostPurchaseResponse.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
    status = json['status'];
    poNumber = json['poNumber'];
    qbVendorID = json['qbVendorID'];
    createdById = json['createdById'];
  }
  String? id;
  String? name;
  bool? deleted;
  String? createdAt;
  String? modifiedAt;
  String? status;
  String? poNumber;
  String? qbVendorID;
  String? createdById;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['deleted'] = deleted;
    map['createdAt'] = createdAt;
    map['modifiedAt'] = modifiedAt;
    map['status'] = status;
    map['poNumber'] = poNumber;
    map['qbVendorID'] = qbVendorID;
    map['createdById'] = createdById;
    return map;
  }

}