import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:organik/models/product_category.dart';
import 'package:provider/provider.dart';
import 'package:organik/constants.dart';
import 'package:organik/models/product.dart';
import 'package:organik/providers/shop_controller.dart';
import 'package:organik/widgets/app_bar_standard.dart';
import 'package:organik/widgets/input_labeled.dart';

class AddUpdateProduct extends StatefulWidget {
  static const ROUTE_NAME = "ProductForm:";

  @override
  _AddUpdateProductState createState() => _AddUpdateProductState();
}

class _AddUpdateProductState extends State<AddUpdateProduct> {
  static const TAG = "AddUpdateProduct:";
  final _formKey = GlobalKey<FormState>();
  final _categoryController = TextEditingController();

  ShopController _productsController;
  Product _product;

  var _name = "";
  var _description = "";
  var _categoryId = "";
  var _price = 0.0;
  // String _unit = "";
  // List<String> _images = [];
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _currentLocal = EasyLocalization.of(context).locale.languageCode;
    _productsController = context.watch<ShopController>();
    _product = ModalRoute.of(context).settings.arguments;
    _isLoading = _productsController.isLoading;

    if (_product != null) {
      //set initial values in the update mode
      _name = _product.name;
      _description = _product.description;
      _categoryId = _product.category;
      print("$TAG catId: $_categoryId");
      _price = _product.price;
      _categoryController.text =
          ProductCategory.getCategoryNameFromId(_categoryId, _currentLocal);
    }
  }

  @override
  Widget build(BuildContext context) {
    _handleCategory(String categoryName) {
      print("$TAG _handleCategory called");
      setState(() {
        _categoryId = ProductCategory.getCategoryIdFromName(categoryName);
        _categoryController.text = categoryName;
        print("selected category id $_categoryId");
      });
    }

    _handleUpdatingProduct() async {
      print("$TAG _handleUpdatingProduct called");
      var message = "";
      if (_product.name == _name &&
          _product.description == _description &&
          _product.category == _categoryId &&
          _product.price == _price) {
        //check if no changes discard an close this screen
        message = "msg_discarded_changes".tr();
      } else {
        if (_isLoading) return;
        Map<String, dynamic> updatedFields = {
          "name": _name,
          "description": _description,
          "category": _categoryId,
          "price": _price,
        };
        Fluttertoast.showToast(
          msg: "msg_updating_product".tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: colorPrimaryLight,
          textColor: colorPrimaryDark,
        );
        await _productsController.updateProduct(_product.id, updatedFields);
        message = "msg_updated_product".tr();
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: colorPrimaryLight,
        textColor: colorPrimaryDark,
      );
      Navigator.of(context).pop();
    }

    _handleAddingProduct() async {
      print("$TAG _handleAddingProduct called");
      var message = "";
      if (_formKey.currentState.validate()) {
        if (_isLoading) return;
        if (_product == null) {
          //handle adding product
          final result = await _productsController.addProduct(
              _name, _description, _categoryId, _price);
          if (result) {
            message = "msg_added_product".tr();
            Navigator.of(context).pop();
          } else {
            message = "error_adding_product".tr();
          }
          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: colorPrimaryLight,
            textColor: colorPrimaryDark,
            fontSize: 16.0,
          );
        } else {
          //handle updating an exist product
          _handleUpdatingProduct();
        }
      }
    }

    return Scaffold(
      backgroundColor: colorBgLight,
      body: Stack(
        children: [
          Column(
            children: [
              StandardAppBar(
                title: _product == null
                    ? "title_new_product".tr()
                    : "title_edit_product".tr(),
                actionIcon: Icons.check_rounded,
                onActionPressed: _handleAddingProduct,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    LabeledInput(
                      label: "label_product_name".tr(),
                      initialValue: _name,
                      isRequiredInput: true,
                      onChanged: (val) => _name = val,
                    ),
                    LabeledInput(
                      label: "label_product_desc".tr(),
                      initialValue: _description,
                      isRequiredInput: true,
                      onChanged: (val) => _description = val,
                    ),
                    LabeledInput(
                      //category container
                      controller: _categoryController,
                      label: "label_category".tr(),
                      // hint: _categoryId,
                      isRequiredInput: true,
                      dropItems: EasyLocalization.of(context).locale ==
                              Locale(langEnCode)
                          ? dropDownCategoriesEn
                          : dropDownCategoriesTr,
                      onDropItemSelected: (categoryName) =>
                          _handleCategory(categoryName),
                      // onChanged: (val) => _description = val,
                    ),
                    LabeledInput(
                      //price container
                      label: "label_product_price".tr(),
                      initialValue: _price == 0 ? "" : _price.toString(),
                      isRequiredInput: true,
                      onChanged: (val) => _price = double.parse(val),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Visibility(
            visible: _isLoading,
            child: Center(
              child: SpinKitDoubleBounce(
                color: colorPrimaryDark,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
