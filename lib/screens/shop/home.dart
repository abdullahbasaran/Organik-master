import 'package:flutter/material.dart';
import 'package:organik/screens/shop/add_update_product.dart';
import 'package:organik/screens/shop/chats_screen.dart';
import 'package:organik/screens/shop/more_options.dart';
import 'package:organik/screens/shop/home_screen.dart';
import 'package:organik/screens/shop/my_shop.dart';
import 'package:organik/widgets/app_bar_home.dart';
import 'package:organik/widgets/item_bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../constants.dart';

class ShopHome extends StatefulWidget {
  static const ROUTE_NAME = "SellerHome";

  @override
  _ShopHomeState createState() => _ShopHomeState();
}

class _ShopHomeState extends State<ShopHome> {
  final _tabs = [HomeScreen(), ChatsScreen(), MyShop(), MoreOptions()];
  int _lastSelected = 0;

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBgLight,
      body: Column(
        children: [
          HomeAppBar(
            customerAppBar: false,
          ),
          Expanded(
            child: _tabs[_lastSelected],
          ),
        ],
      ),
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'Add',
        color: colorPrimaryLight,
        backgroundColor: colorPrimary,
        selectedColor: colorPrimaryDark,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(
            iconData: Icons.home_rounded,
            text: 'nav_home'.tr(),
          ),
          FABBottomAppBarItem(
            iconData: Icons.message_rounded,
            text: 'nav_chats'.tr(),
          ),
          FABBottomAppBarItem(
            iconData: Icons.storefront_rounded,
            text: 'nav_shop'.tr(),
          ),
          FABBottomAppBarItem(
            iconData: Icons.more_horiz_rounded,
            text: 'nav_options'.tr(),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(AddUpdateProduct.ROUTE_NAME),
        tooltip: 'Add Product',
        child: Icon(Icons.add),
        elevation: 2.0,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
