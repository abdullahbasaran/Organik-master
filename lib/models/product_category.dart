import 'package:organik/constants.dart';

class ProductCategory {
  String id;
  String nameEn;
  String nameTr;
  String image;

  //todo you can add the category name key instead and translate it directly
  //for now dealing with only two locales won't make alot of difference
  ProductCategory(this.id, this.nameEn, this.nameTr, this.image);

  //returns the id of the selected item regardless of the local is En or Tr
  static String getCategoryIdFromName(String categoryName) {
    //suppose the categoryName is En and try to get the id
    //from the categories where the categoryName equals to the corresponding item
    //return null otherwise
    String catId = categories
        .firstWhere(
          (cat) => cat.nameEn == categoryName,
          orElse: () => null,
        )
        .id;
    if (catId == null) {
      //if the catId is null then try to check the categories for the Tr values
      catId = categories.firstWhere((cat) => cat.nameTr == categoryName).id;
    }
    return catId;
  }

  //returns the name of the selected item depending on the sent local code
  static String getCategoryNameFromId(String categoryId, String localeCode) {
    String catName = "";
    if (localeCode == langEnCode) {
      catName = categories
          .firstWhere(
            (cat) => cat.id == categoryId,
            orElse: () => null,
          )
          .nameEn;
    }
    if (localeCode == langTrCode) {
      catName = categories
          .firstWhere(
            (cat) => cat.id == categoryId,
            orElse: () => null,
          )
          .nameTr;
    }
    return catName;
  }
}

List<ProductCategory> categories = [
  ProductCategory(
      "all", "All", "Hepsi", "assets/images/all_categories.svg"),
  ProductCategory("butter", "Butter", "Tereyağı", "assets/images/butter.svg"),
  ProductCategory("cheese", "Cheese", "Peynir", "assets/images/cheese.svg"),
  ProductCategory("eggs", "Eggs", "Yumurta", "assets/images/eggs.svg"),
  ProductCategory("fruits", "Fruits", "Meyveler", "assets/images/fruits.svg"),
  ProductCategory("grape", "Grape", "Üzüm", "assets/images/grape.svg"),
  ProductCategory("jam", "Jam", "Reçel", "assets/images/jam.svg"),
  ProductCategory("tomato-sauce", "Tomato Sauce", "Domates sosu",
      "assets/images/tomato-sauce.svg"),
  ProductCategory("meat", "Meat", "Et", "assets/images/meat.svg"),
  ProductCategory("milk", "Milk", "Süt", "assets/images/milk.svg"),
  ProductCategory("pomegranate-syrup", "Pomegranate Syrup", "Nar Ekşisi",
      "assets/images/pomegranate-syrup.svg"),
  ProductCategory(
      "molasses", "Molasses", "Pekmez", "assets/images/molasses.svg"),
  ProductCategory(
      "olive-oil", "Olive Oil", "Zeytin yağı", "assets/images/olive-oil.svg"),
  ProductCategory("olives", "Olives", "Zeytin", "assets/images/olives.svg"),
  ProductCategory("pomegranate", "Pomegranate", "Nar",
      "assets/images/pomegranate.svg"),
  ProductCategory("spices", "Spices", "Baharat", "assets/images/spices.svg"),
  ProductCategory("chicken", "Chicken", "Tavuk", "assets/images/chicken.svg"),
  ProductCategory(
      "vegetable", "Vegetable", "Sebze", "assets/images/vegetable.svg"),
  ProductCategory("walnut", "walnut", "ceviz", "assets/images/walnut.svg"),
  ProductCategory("wheat", "Wheat", "Buğday", "assets/images/wheat.svg"),
  ProductCategory("yogurt", "Yogurt", "Yogurt", "assets/images/yogurt.svg"),
];

List<String> dropDownCategoriesEn = categories.map((e) => e.nameEn).toList();
List<String> dropDownCategoriesTr = categories.map((e) => e.nameTr).toList();
