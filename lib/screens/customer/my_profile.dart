import 'package:flutter/material.dart';
import 'package:organik/constants.dart';
import 'package:organik/providers/customer_controller.dart';
import 'package:organik/utils/dialog_util.dart';
import 'package:provider/provider.dart';

import 'package:organik/services/auth_service.dart';
import 'package:organik/widgets/item_list.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileScreen extends StatelessWidget {
  static const ROUTE_NAME = "ProfileScreen";
  final _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final _customerModel = context.watch<CustomerController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            //top container
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorPrimary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radiusStandard),
                bottomRight: Radius.circular(radiusStandard),
              ),
            ),
            child: _customerModel.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    //customer avatar and name container
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          color: colorPrimaryLight,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.person),
                      ),
                      SizedBox(
                        height: marginStandard,
                      ),
                      Text(
                        _customerModel.customer.name,
                        style: TextStyle(
                          color: colorPrimaryDark,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeMedium,
                        ),
                      ),
                      SizedBox(
                        height: marginStandard,
                      ),
                    ],
                  ),
          ),
          ListItem(
            icon: Icons.message_rounded,
            text: "nav_chats".tr(),
            onTap: () {},
          ),
          ListItem(
            icon: Icons.favorite_rounded,
            text: "option_favorite".tr(),
            onTap: () {},
          ),
          ListItem(
            icon: Icons.shopping_cart_rounded,
            text: "option_my_orders".tr(),
            onTap: () {},
          ),
          ListItem(
            icon: Icons.language,
            text: "option_select_language".tr(),
            onTap: () => DialogUtil.showLangPickerDialog(context),
          ),
          ListItem(
            icon: Icons.settings,
            text: "option_account_settings".tr(),
            onTap: () {},
          ),
          ListItem(
            icon: Icons.login_rounded,
            text: "option_logut".tr(),
            onTap: () {
              _authService.logout();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
