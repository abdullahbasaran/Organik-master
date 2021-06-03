import 'package:flutter/material.dart';
import 'package:organik/constants.dart';

class ShopHeader extends StatelessWidget {
  final int rate;
  final String shopLogo;
  final String shopName;

  const ShopHeader({Key key, this.rate, this.shopLogo, this.shopName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorPrimary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radiusStandard),
          bottomRight: Radius.circular(radiusStandard),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 80,
            padding: const EdgeInsets.all(marginStandard),
            child: Image.asset(
              shopLogo,
            ),
          ),
          Text(
            shopName,
            style: TextStyle(
              fontSize: fontSizeMedium,
              color: colorPrimaryDark,
            ),
          ),
          Row(
            children: [
              Icon(
                rate >= 1 ? Icons.star : Icons.star_outline,
                color: colorPrimaryDark,
              ),
              Icon(
                rate >= 2 ? Icons.star : Icons.star_outline,
                color: colorPrimaryDark,
              ),
              Icon(
                rate >= 3 ? Icons.star : Icons.star_outline,
                color: colorPrimaryDark,
              ),
              Icon(
                rate >= 4 ? Icons.star : Icons.star_outline_outlined,
                color: colorPrimaryDark,
              ),
              Icon(
                rate >= 5 ? Icons.star : Icons.star_outline,
                color: colorPrimaryDark,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
