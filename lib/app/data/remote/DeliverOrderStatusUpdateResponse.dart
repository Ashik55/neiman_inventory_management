class DeliverOrderStatusUpdateResponse {
  DeliverOrderStatusUpdateResponse({
      this.id, 
      this.name, 
      this.deleted, 
      this.description, 
      this.createdAt, 
      this.modifiedAt, 
      this.status, 
      this.createdById, 
      this.createdByName, 
      this.modifiedById, 
      this.modifiedByName, 
      this.assignedUserId, 
      this.assignedUserName, 
      this.salesId, 
      this.salesName,});

  DeliverOrderStatusUpdateResponse.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    deleted = json['deleted'];
    description = json['description'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
    status = json['status'];
    createdById = json['createdById'];
    createdByName = json['createdByName'];
    modifiedById = json['modifiedById'];
    modifiedByName = json['modifiedByName'];
    assignedUserId = json['assignedUserId'];
    assignedUserName = json['assignedUserName'];
    salesId = json['salesId'];
    salesName = json['salesName'];
  }
  String? id;
  dynamic name;
  bool? deleted;
  dynamic description;
  String? createdAt;
  String? modifiedAt;
  String? status;
  String? createdById;
  String? createdByName;
  String? modifiedById;
  String? modifiedByName;
  dynamic assignedUserId;
  dynamic assignedUserName;
  String? salesId;
  String? salesName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['deleted'] = deleted;
    map['description'] = description;
    map['createdAt'] = createdAt;
    map['modifiedAt'] = modifiedAt;
    map['status'] = status;
    map['createdById'] = createdById;
    map['createdByName'] = createdByName;
    map['modifiedById'] = modifiedById;
    map['modifiedByName'] = modifiedByName;
    map['assignedUserId'] = assignedUserId;
    map['assignedUserName'] = assignedUserName;
    map['salesId'] = salesId;
    map['salesName'] = salesName;
    return map;
  }

}