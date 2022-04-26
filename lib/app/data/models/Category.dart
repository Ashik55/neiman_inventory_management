class Category {
  Category({
      this.id, 
      this.name, 
      this.deleted, 
      this.createdById, 
      this.createdByName,});

  Category.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    deleted = json['deleted'].toString().toLowerCase() == "true" ? true : false;
    createdById = json['createdById'];
    createdByName = json['createdByName'];
  }
  String? id;
  String? name;
  bool? deleted;
  String? createdById;
  String? createdByName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['deleted'] = deleted.toString();
    map['createdById'] = createdById;
    map['createdByName'] = createdByName;
    return map;
  }

}