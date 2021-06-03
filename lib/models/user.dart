import 'dart:convert';

MyUser myUserFromJson(String str) => MyUser.fromJson(json.decode(str));

String myUserToJson(MyUser data) => json.encode(data.toJson());

class MyUser {
  static const USER_CUSTOMER = "customer";
  static const USER_SHOP = "shop";

  MyUser({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.type,
  });

  String id;
  String name;
  String email;
  String phone;
  String type;

  factory MyUser.fromJson(Map<String, dynamic> json) => MyUser(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "type": type,
      };

  bool isCustomer() {
    return this.type == USER_CUSTOMER;
  }

  bool isShop() {
    return this.type == USER_SHOP;
  }
}
