import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:organik/constants.dart';
import 'package:organik/models/shop.dart';
import 'package:organik/screens/customer/components/shop_products.dart';
import 'package:organik/screens/customer/components/shop_info.dart';
import 'package:organik/screens/shop/shop_reviews.dart';
import 'package:organik/widgets/shop_name_rating.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class ShopPublicProfile extends StatefulWidget {
  static const ROUTE_NAME = "ShopPublicProfile:";

  @override
  _ShopPublicProfileState createState() => _ShopPublicProfileState();
}

class _ShopPublicProfileState extends State<ShopPublicProfile> {
  var _selectedTab = 0;
  void _setSelectedTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  Widget _getTab(String shopId) {
    switch (_selectedTab) {
      case 0:
        return ShopProducts(
          shopId: shopId,
        );
      case 1:
        return ShopReviews(
          shopId: shopId,
        );
      case 2:
        return ShopInfo(
          shopId: shopId,
        );
      default:
        return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Shop shop = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: marginStandard,
              right: marginStandard,
              bottom: marginLarge,
              top: 50,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radiusLarge),
                  bottomRight: Radius.circular(radiusLarge)),
              color: colorPrimary,
            ),
            child: ShopNameRating(
              onShopPressed: () =>
                  Navigator.of(context).pushNamed(ShopPublicProfile.ROUTE_NAME),
              shopLogo: shop.logo,
              shopName: shop.name,
              rate: shop.rate,
            ),
          ),
          SizedBox(
            height: marginStandard,
          ),
          DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: marginStandard,
                    ),
                    Material(
                      child: TabBar(
                        indicatorColor: Colors.green,
                        tabs: [
                          Tab(
                            text: "label_products".tr(),
                          ),
                          Tab(
                            text: "label_reviews".tr(),
                          ),
                          Tab(
                            text: "label_info".tr(),
                          ),
                        ],
                        onTap: (value) => _setSelectedTab(value),
                        labelColor: colorPrimaryLight,
                        unselectedLabelColor: colorPrimaryDark,
                        indicator: RectangularIndicator(
                          color: colorPrimary,
                          bottomLeftRadius: 100,
                          bottomRightRadius: 100,
                          topLeftRadius: 100,
                          topRightRadius: 100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: marginStandard,
          ),
          Expanded(
            // height: 400,
            child: _getTab(shop.id),
          ),
        ],
      ),
    );
  }
}
