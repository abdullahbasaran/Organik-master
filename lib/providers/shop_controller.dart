import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:organik/models/product.dart';
import 'package:organik/models/shop.dart';
import 'package:organik/services/auth_service.dart';
import 'package:organik/services/database_service.dart';

class ShopController with ChangeNotifier {
  static const TAG = "ShopController:";

  final _dbService = DBService();

  Shop _shop;
  List<Product> _products = [];
  Set<Marker> pickedMarker = {};
  LatLng pickedLatLng;
  var _fetchedProducts = false;
  var _isLoading = false;

  ShopController() {
    fetchProducts();
  }

  bool get fetchedProducts => this._fetchedProducts;
  bool get isLoading => this._isLoading;
  List<Product> get products => this._products;
  Shop get shop {
    if (_shop != null) return _shop;
    getShopProfile();
    return null;
  }

  set isLoading(bool loading) {
    this._isLoading = loading;
    notifyListeners();
  }

  set fetchedProducts(bool fetched) {
    this._fetchedProducts = fetched;
  }

  set shop(Shop shop) {
    this._shop = shop;
    notifyListeners();
  }

  void fetchProducts() async {
    print("$TAG fetching shop products from server..");

    isLoading = true;
    _products = await _dbService.getProductsForShop(null);
    // _products.length > 0 ? fetchedProducts = true : fetchedProducts = false;
    fetchedProducts = true;
    isLoading = false;
  }

  Future<bool> addProduct(
      String name, String desc, String category, double price) async {
    print("$TAG adding new product to the current shop..");
    print("$TAG name: $name, desc: $desc");
    isLoading = true;
    final added = await _dbService.addNewProduct(name, desc, category, price);
    if (added)
      fetchProducts();
    else
      isLoading = false;
    return added;
  }

  Future<void> updateProduct(
      String productId, Map<String, dynamic> updatedFields) async {
    print("$TAG updaing product..");
    isLoading = true;
    await _dbService.updateProduct(productId, updatedFields);
    fetchProducts();
  }

  Future<void> getShopProfile() async {
    print("$TAG getting shop profile from server..");
    _isLoading = true;
    shop = await _dbService.getMyShopProfile();
    if (shop?.geoPoint != null) {
      final latLng = LatLng(shop.geoPoint.latitude, shop.geoPoint.longitude);
      updatePickedMarker(latLng);
    }
    isLoading = false;
  }

  Future<void> updateProfileField(String field, dynamic newData) async {
    print("$TAG updating shop profile field $field to ${newData.toString()}..");
    await _dbService.updateShopProfileField(field, newData);
    getShopProfile();
  }

  Future<void> refreshProducts() async {
    print("$TAG refreshing shop products from server..");
    _products = await _dbService.getProductsForShop(null);
    notifyListeners();
  }

  Future<void> updateShopLocation(LatLng latLng) async {
    print("$TAG updateShopLocation called");
    await _dbService.updateShopLocation(latLng);
    await getShopProfile();
    notifyListeners();
  }

  void updatePickedMarker(LatLng latLng) async {
    print("$TAG upadting marker pin to $latLng");
    pickedLatLng = latLng;
    pickedMarker = {};
    Marker marker = Marker(
      markerId: MarkerId("my_location"),
      position: LatLng(latLng.latitude, latLng.longitude),
      infoWindow: InfoWindow(),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      onTap: () {
        // print("$TAG tapped marker for taxi ${taxiDriver.id}");
      },
      draggable: true,
      onDragEnd: (latLng) => updatePickedMarker(latLng),
    );
    pickedMarker.add(marker);
    notifyListeners();
  }

  void update(AuthService authService) {
    print("$TAG updaing ShopController ..");
    if (authService != null) {
      fetchProducts();
    }
  }
}
