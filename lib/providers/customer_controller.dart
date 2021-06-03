import 'package:flutter/cupertino.dart';
import 'package:organik/models/customer.dart';
import 'package:organik/models/product.dart';
import 'package:organik/models/product_category.dart';
import 'package:organik/services/auth_service.dart';
import 'package:organik/services/database_service.dart';

class CustomerController with ChangeNotifier {
  static const TAG = "CustomerController:";

  final _dbService = DBService();

  Customer customer;
  List<Product> _products = [];
  List<Product> _filteredProducts = [];

  var _selectedCategoryIndex = 0;
  var _fetchedProducts = false;
  var _isLoading = false;
  var _addingFavoriteId = "";
  var _currentCategory = "all";

  CustomerController() {
    getCustomerProfile();
    fetchProducts();
  }

  int get selectedCategoryIndex => this._selectedCategoryIndex;
  bool get fetchedProducts => this._fetchedProducts;
  bool get isLoading => this._isLoading;
  String get addingFavoriteId => this._addingFavoriteId;
  // String get currentCategory => this._currentCategory;
  List<Product> get products => this._filteredProducts;

  set isLoading(bool loading) {
    this._isLoading = loading;
    notifyListeners();
  }

  set addingFavoriteId(String id) {
    this._addingFavoriteId = id;
    notifyListeners();
  }

  set fetchedProducts(bool fetched) {
    this._fetchedProducts = fetched;
  }

  set selectedCategoryIndex(int index) {
    this._selectedCategoryIndex = index;
  }

  void fetchProducts() async {
    print("$TAG checking if products null to fetch them from server..");
    if (_products.length == 0) {
      _isLoading = true;
      _products = await _dbService.getAllProducts();
      _filteredProducts = _products;
      // _products.length > 0 ? fetchedProducts = true : fetchedProducts = false;
      fetchedProducts = true;
      isLoading = false;
    }
  }

  Future<void> refreshProducts() async {
    print("$TAG refreshing shop products from server..");
    _products = await _dbService.getAllProducts();
    notifyListeners();
  }

  bool isFavoriteProduct(String productId) {
    if (customer?.favorites != null) {
      return customer.favorites.contains(productId);
    }
    return false;
  }

  void getCustomerProfile() async {
    print("$TAG getting customer profile..");
    _isLoading = true;
    customer = await _dbService.getCustomerProfile();
    isLoading = false;
  }

  void filterProductsByCategory(String cat) {
    if (cat == categories[0].id)
      _filteredProducts = _products;
    else
      _filteredProducts = List.from(_products.where((e) => e.category == cat));
    notifyListeners();
  }

  void filterProductsBySearch(String input) {
    selectedCategoryIndex = 0;
    if (input.isEmpty)
      filterProductsByCategory(_currentCategory);
    else
      _filteredProducts =
          List.from(_products.where((e) => e.name.contains(input)));
    notifyListeners();
  }

  void update(AuthService authService) {
    print("$TAG updating CustomerController ..");
    if (authService.isLoggedIn) {
      getCustomerProfile();
      fetchProducts();
    }
  }

  void toggleFavorite(String productId) async {
    print("$TAG called toggleFavorite");
    addingFavoriteId = productId;
    final result = await _dbService.toggleFavorite(customer, productId);
    if (result != null) {
      if (result == "added") {
        customer.favorites.add(productId);
      }
      if (result == "deleted") {
        customer.favorites.remove(productId);
      }
    }
    addingFavoriteId = "";
  }
}
