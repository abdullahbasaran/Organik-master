import 'package:cloud_firestore/cloud_firestore.dart';

List<Review> reviewsFromSnapshot(QuerySnapshot snapshot) =>
    List<Review>.generate(snapshot.size,
            (index) => Review.fromJson(snapshot.docs.elementAt(index).data()))
        .toList();

class Review {
  String id;
  String reviewerId;
  String reviewedShopId;
  String imageUrl;
  int rate;
  String text;
  Timestamp timestamp;

  Review({
    this.id,
    this.reviewerId,
    this.reviewedShopId,
    this.imageUrl,
    this.rate,
    this.text,
    this.timestamp,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        reviewerId: json["reviewer_id"],
        reviewedShopId: json["reviewed_shop_id"],
        imageUrl: json["imageUrl"],
        rate: json["rate"],
        text: json["text"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reviewer_id": reviewerId,
        "reviewed_shop_id": reviewedShopId,
        "imageUrl": imageUrl,
        "rate": rate,
        "text": text,
        "timestamp": timestamp,
      };

  @override
  String toString() {
    return """    "id": id,
        "reviewer_id": reviewerId,
        "reviewed_shop_id": reviewedShopId,
        "imageUrl": imageUrl,
        "rate": rate,
        "text": text,
        "timestamp": timestamp,""";
  }

  static List<Review> reviews = [
    Review(
        id: "1",
        reviewerId: "Ali",
        imageUrl: "",
        rate: 4,
        text:
            "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea.",
        timestamp: null),
    Review(
        id: "1",
        reviewerId: "Mehmet",
        imageUrl: "",
        rate: 3,
        text:
            "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam",
        timestamp: null),
    Review(
        id: "1",
        reviewerId: "Ahmet",
        imageUrl: "",
        rate: 2,
        text:
            "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam",
        timestamp: null),
    Review(
        id: "1",
        reviewerId: "Sait",
        imageUrl: "",
        rate: 1,
        text:
            "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam",
        timestamp: null),
  ];
}
