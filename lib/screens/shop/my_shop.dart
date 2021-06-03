import 'package:flutter/material.dart';
import 'package:organik/constants.dart';
import 'package:organik/screens/shop/shop_info.dart';
import 'package:organik/screens/shop/shop_reviews.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:easy_localization/easy_localization.dart';

class MyShop extends StatefulWidget {
  static const ROUTE_NAME = "AddProduct";

  @override
  _MyShopState createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  var _selectedTab = 0;
  void _setSelectedTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  final _tabs = [ShopInfo(), ShopReviews()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DefaultTabController(
            length: 2,
            initialIndex: _selectedTab,
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
                            text: "label_my_shop".tr(),
                          ),
                          Tab(
                            text: "label_reviews".tr(),
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
            child: _tabs[_selectedTab],
          ),
        ],
      ),
    );
  }
}
