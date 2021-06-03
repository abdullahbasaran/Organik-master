class Customer {
  String id;
  String name;
  String avatar;
  List<dynamic> favorites;

  Customer({
    this.id,
    this.name,
    this.avatar,
    this.favorites,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        favorites: json["favorites"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "favorites": favorites,
      };
}
