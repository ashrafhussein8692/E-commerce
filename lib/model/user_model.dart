class UserModel {
  bool status = true;
  String? message;
  Data? data;

  UserModel({
    required this.status,
    this.message,
    this.data});

  UserModel.fromJson(dynamic json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }



}

class Data {
  String? name;
  String? email;
  String? phone;
  int? id;
  String? image;
  String? token;

  Data({
    this.name,
    this.email,
    this.phone,
    this.id,
    this.image,
    this.token});

  Data.fromJson(dynamic json) {
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    id = json["id"];
    image = json["image"];
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["email"] = email;
    map["phone"] = phone;
    map["id"] = id;
    map["image"] = image;
    map["token"] = token;
    return map;
  }

}