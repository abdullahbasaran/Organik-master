import 'package:cloud_firestore/cloud_firestore.dart';

List<Shop> shopsFromSnapshot(QuerySnapshot snapshot) => List<Shop>.generate(
    snapshot.size,
    (index) => Shop.fromJson(snapshot.docs.elementAt(index).data())).toList();

class Shop {
  static const DB_FIELD_NAME = "name";
  static const DB_FIELD_ADDRESS = "address";
  static const DB_FIELD_BIO = "bio";
  static const DB_FIELD_CATEGORIES = "categories";
  static const DB_FIELD_PHONE = "phone";
  static const DB_FIELD_WEBSITE = "website";
  static const DB_FIELD_WORKING_HOURS = "working_hours";

  String id;
  String logo;
  String name;
  String bio;
  String website;
  String phoneNumber;
  String address;
  int rate;
  List<dynamic> workingHours;
  List<dynamic> categories;
  GeoPoint geoPoint;

  Shop({
    this.id,
    this.logo,
    this.name,
    this.bio,
    this.website,
    this.phoneNumber,
    this.address,
    this.rate,
    this.workingHours,
    this.categories,
    this.geoPoint,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        logo: json["logo"],
        name: json["name"],
        bio: json["bio"],
        website: json["website"],
        phoneNumber: json["phone"],
        address: json["address"],
        rate: json["rate"],
        workingHours: json["working_hours"],
        categories: json["categories"],
        geoPoint: json["geo_point"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo": logo,
        "name": name,
        "bio": bio,
        "website": website,
        "phone": phoneNumber,
        "address": address,
        "rate": rate,
        "working_hours": workingHours,
        "categories": categories,
        "geo_point": geoPoint,
      };
}
