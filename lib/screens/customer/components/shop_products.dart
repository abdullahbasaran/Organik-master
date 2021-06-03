import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:organik/constants.dart';
import 'package:organik/models/product.dart';
import 'package:organik/screens/customer/product_details.dart';
import 'package:organik/services/database_service.dart';
import 'package:organik/widgets/item_product_grid.dart';

class ShopProducts extends StatelessWidget {
  final _dbService = DBService();
  final String shopId;

  ShopProducts({Key key, @required this.shopId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    int _getColNum() {
      if (_size.width <= MAX_WIDTH) {
        return 2;
      }
      return _size.width ~/ (MAX_WIDTH / 2);
    }

    return Container(
      padding: const EdgeInsets.only(
        top: marginStandard,
        left: marginStandard,
        right: marginStandard,
      ),
      child: FutureBuilder(
        future: _dbService.getProductsForShop(shopId),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.all(marginLarge),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("error fetching products data :("),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text("msg_no_product_for_shop".tr()),
            );
          }
          List<Product> products = snapshot.data;
          if (products.length == 0) {
            return Center(
              child: Text("msg_no_product_for_shop".tr()),
            );
          }

          return GridView.builder(
            // physics: NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _getColNum(),
              mainAxisSpacing: marginStandard,
              crossAxisSpacing: marginStandard,
            ),
            itemBuilder: (cntx, index) {
              return ProductGridItem(
                image: products[index].images[0],
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (builder) => ProductDetails(
                        displayFromShop: true,
                        product: products[index],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
