import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

List<Product> productsFromSnapshot(QuerySnapshot snapshot) =>
    List<Product>.generate(snapshot.size,
            (index) => Product.fromJson(snapshot.docs.elementAt(index).data()))
        .toList();

class Product {
  Product(
      {this.id,
      this.name,
      this.description,
      this.shopId,
      this.images,
      this.category,
      this.price,
      this.timestamp});

  String id;
  String name;
  String description;
  String shopId;
  List<String> images;
  String category;
  double price;
  Timestamp timestamp;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        shopId: json["shop_id"],
        images: List<String>.from(json["images"].map((x) => x)),
        category: json["category"],
        price: json["price"].toDouble(),
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "shop_id": shopId,
        "images": List<dynamic>.from(images.map((x) => x)),
        "category": category,
        "price": price,
        "timestamp": timestamp,
      };
}
