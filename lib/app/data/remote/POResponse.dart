class PoResponse {
  PoResponse({
      this.id, 
      this.deleted, 
      this.createdAt, 
      this.modifiedAt, 
      this.qty, 
      this.qtyStock, 
      this.createdById, 
      this.productId,});

  PoResponse.fromJson(dynamic json) {
    id = json['id'];
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
    qty = json['qty'];
    qtyStock = json['qtyStock'];
    createdById = json['createdById'];
    productId = json['productId'];
  }
  String? id;
  bool? deleted;
  String? createdAt;
  String? modifiedAt;
  int? qty;
  int? qtyStock;
  String? createdById;
  String? productId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['deleted'] = deleted;
    map['createdAt'] = createdAt;
    map['modifiedAt'] = modifiedAt;
    map['qty'] = qty;
    map['qtyStock'] = qtyStock;
    map['createdById'] = createdById;
    map['productId'] = productId;
    return map;
  }

}