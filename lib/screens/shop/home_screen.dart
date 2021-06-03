import 'package:flutter/material.dart';
import 'package:organik/constants.dart';
import 'package:organik/providers/shop_controller.dart';
import 'package:organik/screens/customer/product_details.dart';
import 'package:organik/screens/shop/components/empty_shop.dart';
import 'package:organik/screens/shop/add_update_product.dart';
import 'package:organik/widgets/item_product_grid.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatelessWidget {
  static const ROUTE_NAME = "ShopHomeScreen";
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _productsController = context.watch<ShopController>();
    void _onRefresh() async {
      print("_onRefresh called");
      // monitor network fetch
      // await Future.delayed(Duration(milliseconds: 1000));
      await _productsController
          .refreshProducts()
          .catchError((_) => _refreshController.refreshFailed());
      // if failed,use refreshFailed()
      _refreshController.refreshCompleted();
    }

    int _getColNum() {
      if (_size.width <= MAX_WIDTH) {
        return 2;
      }
      return _size.width ~/ (MAX_WIDTH / 2);
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: marginStandard,
          left: marginStandard,
          right: marginStandard,
        ),
        child: _productsController.products.length > 0
            ? Container(
                height: double.infinity,
                width: double.infinity,
                child: _productsController.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SmartRefresher(
                        controller: _refreshController,
                        onRefresh: _onRefresh,
                        enablePullUp: false,
                        enablePullDown: true,
                        header: WaterDropHeader(),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: _getColNum(),
                            crossAxisSpacing: marginLarge,
                            mainAxisSpacing: marginLarge,
                          ),
                          itemCount: _productsController.products.length,
                          itemBuilder: (ctx, index) {
                            return ProductGridItem(
                              editIconEnabled: true,
                              image:
                                  _productsController.products[index].images[0],
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (builder) => ProductDetails(
                                      displayFromShop: true,
                                      product:
                                          _productsController.products[index],
                                    ),
                                  ),
                                  // arguments: products[index],
                                );
                              },
                              onActionTap: () {
                                Navigator.of(context).pushNamed(
                                  AddUpdateProduct.ROUTE_NAME,
                                  arguments:
                                      _productsController.products[index],
                                );
                              },
                            );
                          },
                        ),
                      ),
              )
            : Center(
                child: EmptyShopMessage(
                  onTap: () => Navigator.of(context)
                      .pushNamed(AddUpdateProduct.ROUTE_NAME),
                ),
              ),
      ),
    );
  }
}
