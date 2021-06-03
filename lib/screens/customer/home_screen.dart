import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:organik/screens/customer/components/no_products.dart';
import 'package:organik/utils/dialog_util.dart';
import 'package:provider/provider.dart';
import 'package:organik/constants.dart';
import 'package:organik/models/product_category.dart';
import 'package:organik/providers/customer_controller.dart';
import 'package:organik/screens/customer/my_profile.dart';
import 'package:organik/screens/customer/product_details.dart';
import 'package:organik/widgets/app_bar_home.dart';
import 'package:organik/widgets/item_category_top.dart';
import 'package:organik/widgets/item_product_grid.dart';
import 'package:organik/widgets/search_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerHome extends StatelessWidget {
  static const ROUTE_NAME = "CustomerHome";
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _productsController = context.watch<CustomerController>();
    final _products = _productsController.products;

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
      backgroundColor: colorBgLight,
      body: Column(
        children: [
          HomeAppBar(
            onProfileClick: () => Navigator.of(context).pushNamed(
              ProfileScreen.ROUTE_NAME,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                top: marginStandard,
                left: marginStandard,
                right: marginStandard,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SearchBar(
                    onChanged: (input) =>
                        _productsController.filterProductsBySearch(input),
                  ),
                  SizedBox(
                    height: marginStandard,
                  ),
                  Container(
                    height: 90,
                    child: Center(
                      child: ListView.builder(
                        // shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (c, i) {
                          return Center(
                            child: CategoryTopItem(
                              isSelected:
                                  _productsController.selectedCategoryIndex ==
                                      i,
                              text: categories[i].nameEn,
                              image: categories[i].image,
                              onTap: () {
                                _productsController
                                    .filterProductsByCategory(categories[i].id);
                                _productsController.selectedCategoryIndex = i;
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: _productsController.isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : _products.length == 0
                            ? _productsController.fetchedProducts
                                ? NoProductMessage()
                                : Center(
                                    child: Text("no products"),
                                  )
                            : SmartRefresher(
                                controller: _refreshController,
                                onRefresh: _onRefresh,
                                enablePullUp: false,
                                enablePullDown: true,
                                header: WaterDropHeader(),
                                child: GridView.builder(
                                  // physics: NeverScrollableScrollPhysics(),
                                  itemCount: _products.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: _getColNum(),
                                    mainAxisSpacing: marginStandard,
                                    crossAxisSpacing: marginStandard,
                                  ),
                                  itemBuilder: (cntx, index) {
                                    return ProductGridItem(
                                      image: _productsController
                                          .products[index].images[0],
                                      isLoading: _productsController
                                              .addingFavoriteId ==
                                          _products[index].id,
                                      isFavorite:
                                          _productsController.isFavoriteProduct(
                                              _products[index].id),
                                      onActionTap: () => _productsController
                                          .toggleFavorite(_productsController
                                              .products[index].id),
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (builder) =>
                                                ProductDetails(
                                              product: _productsController
                                                  .products[index],
                                            ),
                                          ),
                                          // arguments: products[index],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
