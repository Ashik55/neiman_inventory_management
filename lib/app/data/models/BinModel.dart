class BinModel {
  BinModel({
      this.id, 
      this.name, 
      this.deleted, 
      this.description, 
      this.createdAt, 
      this.modifiedAt, 
      this.createdById, 
      this.createdByName, 
      this.modifiedById, 
      this.modifiedByName, 
      this.assignedUserId, 
      this.assignedUserName,});

  BinModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    deleted = json['deleted'];
    description = json['description'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
    createdById = json['createdById'];
    createdByName = json['createdByName'];
    modifiedById = json['modifiedById'];
    modifiedByName = json['modifiedByName'];
    assignedUserId = json['assignedUserId'];
    assignedUserName = json['assignedUserName'];
  }
  String? id;
  String? name;
  bool? deleted;
  String? description;
  String? createdAt;
  String? modifiedAt;
  String? createdById;
  String? createdByName;
  String? modifiedById;
  String? modifiedByName;
  String? assignedUserId;
  String? assignedUserName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['deleted'] = deleted;
    map['description'] = description;
    map['createdAt'] = createdAt;
    map['modifiedAt'] = modifiedAt;
    map['createdById'] = createdById;
    map['createdByName'] = createdByName;
    map['modifiedById'] = modifiedById;
    map['modifiedByName'] = modifiedByName;
    map['assignedUserId'] = assignedUserId;
    map['assignedUserName'] = assignedUserName;
    return map;
  }

}