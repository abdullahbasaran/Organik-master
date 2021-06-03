import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:organik/constants.dart';
import 'package:organik/widgets/rating_stars.dart';

class ShopNameRating extends StatelessWidget {
  const ShopNameRating({
    Key key,
    @required this.rate,
    @required this.shopLogo,
    @required this.shopName,
    @required this.onShopPressed,
  });

  final int rate;
  final String shopLogo;
  final String shopName;
  final Function onShopPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onShopPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 80,
            width: 80,
            padding: const EdgeInsets.all(marginStandard),
            // child: Image.network(shopLogo),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: shopLogo ?? shopLogo,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                shopName,
                style: TextStyle(
                  fontSize: fontSizeMedium,
                  color: colorPrimaryDark,
                ),
              ),
              RatingStars(
                rate: rate,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
