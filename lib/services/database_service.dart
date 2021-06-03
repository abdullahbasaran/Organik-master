import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:organik/models/customer.dart';
import 'package:organik/models/product.dart';
import 'package:organik/models/review.dart';
import 'package:organik/models/shop.dart';
import 'package:organik/models/user.dart';

class DBService {
  static const TAG = "DBService:";

  static const _COL_USERS = "users";
  static const _COL_PRODUCTS = "products";
  static const _COL_SHOPS = "shops";
  static const _COL_REVIEWS = "reviews";
  static const _COL_CUSTOMERS = "customers";

  final _auth = FirebaseAuth.instance;
  final _dbRef = FirebaseFirestore.instance;

  final GetOptions getOptionsFromServerOnly = GetOptions(source: Source.server);

  Future<void> createNewUser(MyUser myUser) async {
    print("$TAG creating new user data ${myUser.toString()}");
    _dbRef
        .collection(_COL_USERS)
        .doc(myUser.id)
        .set(myUser.toJson())
        .then((value) {
      print("$TAG created new user in db");
      //check whether the current user is a shop to create new shop profile
      if (myUser.isShop()) _createNewShop(myUser);
    }).catchError((error) => print("$TAG $error"));
  }

  Future<void> _createNewShop(MyUser myUser) {
    final shop = Shop(
        id: myUser.id,
        logo: "",
        name: myUser.name,
        bio: "",
        website: "",
        phoneNumber: myUser.phone,
        address: "",
        rate: 0,
        workingHours: [],
        categories: [],
        geoPoint: null);
    return _dbRef
        .collection(_COL_SHOPS)
        .doc(myUser.id)
        .set(shop.toJson())
        .then((value) => print("$TAG created new shop in db"))
        .catchError((error) => print("$TAG $error"));
  }

  Future<MyUser> getUserData(User user) async {
    print("$TAG retrieving user data for user ${user.uid}");
    MyUser myUser;
    await _dbRef.collection(_COL_USERS).doc(user.uid).get().then((value) {
      print("$TAG retrieved user data from db");
      myUser = MyUser.fromJson(value.data());
    }).catchError((error) => print("$TAG $error"));
    return myUser;
  }

  ///returns the products for specific shop, passing null
  ///will retreive the products for the logged in shop
  Future<List<Product>> getProductsForShop(String shopId) async {
    //check the shopId to figure whether the method called from customer or shop
    final id = shopId != null ? shopId : _auth.currentUser.uid;
    print("$TAG retrieving products data for shop $id..");
    List<Product> products;
    await _dbRef
        .collection(_COL_PRODUCTS)
        .where("shop_id", isEqualTo: id)
        // .orderBy("timestamp", descending: true)
        .get()
        .then((value) {
      print("$TAG retrieved products for shop $id");
      products = productsFromSnapshot(value);
    }).catchError((error) => print("$TAG $error"));
    return products;
  }

  Future<Shop> getMyShopProfile() {
    final id = _auth.currentUser.uid;
    print("$TAG retrieving shop profile for shop $id..");
    return _dbRef
        .collection(_COL_SHOPS)
        .doc(id)
        .get()
        .then((value) => Shop.fromJson(value.data()))
        .catchError((error) {
      print("$TAG $error");
      return null;
    });
  }

  Future<Customer> getCustomerProfile() {
    final id = _auth.currentUser?.uid;
    print("$TAG retrieving customer profile for user $id..");
    return _dbRef
        .collection(_COL_CUSTOMERS)
        .doc(id)
        .get()
        .then((value) => Customer.fromJson(value.data()))
        .catchError((error) {
      print("$TAG $error");
      return null;
    });
  }

  Future<void> createNewCustomerProfile(String userId, String name) {
    final id = _auth.currentUser.uid;
    print("$TAG adding new customer profile..");
    final customer = Customer(
      id: id,
      name: name,
    );
    return _dbRef
        .collection(_COL_CUSTOMERS)
        .doc(id)
        .set(customer.toJson())
        .then((value) {
      print("$TAG done adding new customer profile..");
    }).catchError((error) {
      print("$TAG $error");
      return null;
    });
  }

  ///returns all products for customer home screen
  Future<List<Product>> getAllProducts() async {
    print("$TAG retrieving products data from db..");
    List<Product> products;
    await _dbRef
        .collection(_COL_PRODUCTS)
        .orderBy("timestamp", descending: true)
        .get(getOptionsFromServerOnly)
        .then((value) {
      print("$TAG retrieved products from db");
      products = productsFromSnapshot(value);
    }).catchError((error) => print("$TAG $error"));
    return products;
  }

  ///returns the reviews for specific shop, passing null
  ///will retreive the reviews for the logged in shop
  Future<List<Review>> getShopReviews(String shopId) async {
    //check the shopId to figure whether the method called from customer or shop
    final id = shopId != null ? shopId : _auth.currentUser.uid;
    print("$TAG retrieving reviews data for shop $id..");
    List<Review> reviews;
    await _dbRef
        .collection(_COL_REVIEWS)
        .where("reviewed_shop_id", isEqualTo: id)
        .get()
        .then((value) {
      print("$TAG retrieved reviews for shop $id");
      // print("$TAG review 0 ${reviews[0].toString()}");
      reviews = reviewsFromSnapshot(value);
    }).catchError((error) => print("$TAG $error"));
    return reviews;
  }

  Future<Shop> getShop(String shopId) async {
    print("$TAG retrieving shop data for $shopId");
    Shop shop;
    await _dbRef.collection(_COL_SHOPS).doc(shopId).get().then((value) {
      print("$TAG retrieved shop from db");
      shop = Shop.fromJson(value.data());
    }).catchError((error) => print("$TAG $error"));
    return shop;
  }

  Future<String> toggleFavorite(Customer customer, String productId) {
    print("$TAG toggled favorite for $productId");
    final favorites = customer.favorites;
    var result = "";
    if (favorites.contains(productId)) {
      //delete this product from favorite list
      print("$TAG deleting prodcut $productId from favorite");
      result = "deleted";
      favorites.remove(productId);
    } else {
      //add this product to favorite list
      print("$TAG adding prodcut $productId to favorite");
      result = "added";
      favorites.add(productId);
    }
    Map<String, dynamic> newFavList = {"favorites": favorites};
    return _dbRef
        .collection(_COL_CUSTOMERS)
        .doc(customer.id)
        .update(newFavList)
        .then((value) {
      print("$TAG done toggle favorite for $productId");
      return result;
    }).catchError((error) {
      print("$TAG $error");
      return null;
    });
  }

  Future<List<Shop>> getAllShops() {
    print("$TAG getting all shops..");
    return _dbRef
        .collection(_COL_SHOPS)
        .get()
        .then((value) => shopsFromSnapshot(value))
        .catchError((error) {
      print("$TAG $error");
    });
  }

  Future<bool> addNewProduct(
      String name, String desc, String category, double price) async {
    final id = _auth.currentUser.uid;
    print("$TAG adding new product to shop $id ..");

    final productId = _dbRef.collection(_COL_PRODUCTS).doc().id;
    print("$TAG genereted id $productId");
    final Product product = Product(
      id: productId,
      shopId: id,
      name: name,
      description: desc,
      category: category,
      price: price,
      images: [""],
    );
    print("$TAG name: ${product.name}, desc: ${product.description}");

    await _dbRef
        .collection(_COL_PRODUCTS)
        .doc(productId)
        .set(product.toJson())
        .catchError((error) {
      print("$TAG $error");
      return false;
    });
    //check if the product added successfully
    return _existProduct(productId);
  }

  Future<bool> _existProduct(String productId) {
    return _dbRef
        .collection(_COL_PRODUCTS)
        .doc(productId)
        .get()
        .then((value) => value.exists);
  }

  Future<void> updateProduct(
      String productId, Map<String, dynamic> updatedFields) async {
    print("$TAG updating product $productId ..");

    return _dbRef
        .collection(_COL_PRODUCTS)
        .doc(productId)
        .update(updatedFields)
        .catchError((error) {
      print("$TAG $error");
    });
  }

  Future<void> updateShopProfileField(String field, dynamic newData) async {
    final id = _auth.currentUser.uid;
    print("$TAG updating shop profile for $id ..");
    return _dbRef
        .collection(_COL_SHOPS)
        .doc(id)
        .update({field: newData}).catchError((error) {
      print("$TAG $error");
    });
  }

  Future<void> updateShopLocation(LatLng latLng) {
    final id = _auth.currentUser.uid;
    print("$TAG updating shop location to $latLng ..");
    final _geoPoint = GeoPoint(latLng.latitude, latLng.longitude);
    Map<String, dynamic> newLocation = {"geo_point": _geoPoint};
    return _dbRef
        .collection(_COL_SHOPS)
        .doc(id)
        .update(newLocation)
        .then((value) {
      print("$TAG updated user location");
    }).catchError((error) {
      print("$TAG $error");
    });
  }
}
