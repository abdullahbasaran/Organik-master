import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:organik/constants.dart';
import 'package:organik/models/shop.dart';
import 'package:organik/widgets/button_standard.dart';
import 'package:organik/widgets/shop_name_rating.dart';

class ShopCardItem extends StatelessWidget {
  final Shop shop;
  final Function onVisitShopPressed;
  final Function onCardPressed;

  const ShopCardItem(
      {Key key, this.shop, this.onVisitShopPressed, this.onCardPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      width: _size.width * 0.7,
      height: _size.height * 0.3,
      padding: const EdgeInsets.all(marginStandard),
      margin: const EdgeInsets.symmetric(horizontal: marginStandard),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radiusStandard),
        ),
        color: colorPrimaryLight,
      ),
      child: InkWell(
        onTap: onCardPressed,
        child: Column(
          children: [
            ShopNameRating(
              rate: shop.rate,
              shopLogo: shop.logo,
              shopName: shop.name,
              onShopPressed: null,
            ),
            Expanded(
              child: Center(
                child: Text(
                  shop.bio,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
            SizedBox(
              height: marginStandard,
            ),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: marginStandard),
              child: StandardButton(
                width: double.infinity,
                text: "btn_visit_shop".tr(),
                onButtonPressed: onVisitShopPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
