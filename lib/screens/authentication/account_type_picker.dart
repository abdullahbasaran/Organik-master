import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:organik/constants.dart';
import 'package:organik/screens/authentication/register_screen.dart';
import 'package:organik/widgets/app_header.dart';
import 'package:organik/widgets/item_grid.dart';

class AccountTypePicker extends StatelessWidget {
  static const ROUTE_NAME = "AccountTypePicker";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final itemWidth = size.width / 2 - marginLarge * 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBgDark,
        elevation: 0,
      ),
      backgroundColor: colorBgDark,
      body: Container(
        padding: EdgeInsets.all(marginStandard),
        child: Column(
          children: [
            AppHeader(
              bigHeader: true,
            ),
            Spacer(
              flex: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GridItem(
                  width: itemWidth,
                  height: itemWidth,
                  text: "label_iam_customer".tr(),
                  image: IMG_PERSON,
                  onTap: () => Navigator.of(context).pushReplacementNamed(
                      RegisterAccountScreen.ROUTE_NAME,
                      arguments: UserType.CUSTOMER),
                ),
                GridItem(
                  width: itemWidth,
                  height: itemWidth,
                  text: "label_iam_seller".tr(),
                  image: IMG_CART,
                  onTap: () => Navigator.of(context).pushReplacementNamed(
                      RegisterAccountScreen.ROUTE_NAME,
                      arguments: UserType.SHOP),
                ),
              ],
            ),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
