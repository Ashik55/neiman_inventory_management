class UserModel {
  UserModel({
    this.user,
  });

  UserModel.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}

class User {
  User({
    this.id,
    this.name,
    this.userName,
    this.type,
    this.firstName,
    this.lastName,
    this.isActive,
    this.accountsIds,
    this.createdById,
    this.createdByName,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    userName = json['userName'];
    type = json['type'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    isActive = json['isActive'];
    accountsIds = json['accountsIds'] != null ? json['accountsIds'].cast<String>() : [];
    createdById = json['createdById'];
    createdByName = json['createdByName'];
  }

  String? id;
  String? name;
  String? userName;
  String? type;
  String? firstName;
  String? lastName;
  List<String>? accountsIds = [];
  bool? isActive;
  String? createdById;
  String? createdByName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['userName'] = userName;
    map['type'] = type;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['isActive'] = isActive;
    map['createdById'] = createdById;
    map['createdByName'] = createdByName;
    return map;
  }
}
