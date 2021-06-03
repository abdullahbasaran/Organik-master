import 'package:flutter/material.dart';
import 'package:organik/utils/dialog_util.dart';
import 'package:provider/provider.dart';

import 'package:organik/services/auth_service.dart';
import 'package:organik/widgets/item_list.dart';
import 'package:easy_localization/easy_localization.dart';

class MoreOptions extends StatelessWidget {
  static const ROUTE_NAME = "AddProduct";
  @override
  Widget build(BuildContext context) {
    final _authService = context.watch<AuthService>();
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListItem(
                icon: Icons.shopping_cart_rounded,
                text: "option_my_orders".tr(),
                onTap: () {},
              ),
              ListItem(
                icon: Icons.language_rounded,
                text: "option_select_language".tr(),
                onTap: () => DialogUtil.showLangPickerDialog(context),
              ),
              ListItem(
                icon: Icons.settings_rounded,
                text: "option_account_settings".tr(),
                onTap: () {},
              ),
              ListItem(
                icon: Icons.login_rounded,
                text: "option_logut".tr(),
                onTap: () => _authService.logout(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
