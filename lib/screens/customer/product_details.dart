import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:organik/screens/image_preview.dart';
import 'package:provider/provider.dart';
import 'package:organik/models/shop.dart';
import 'package:organik/providers/customer_controller.dart';
import 'package:organik/screens/customer/shop_public_profile.dart';
import 'package:organik/services/database_service.dart';
import 'package:organik/constants.dart';
import 'package:organik/models/product.dart';
import 'package:organik/widgets/button_standard.dart';
import 'package:organik/widgets/shop_name_rating.dart';
import 'package:organik/widgets/static_map.dart';

class ProductDetails extends StatelessWidget {
  static const ROUTE_NAME = "ProductDetails";

  final Product product;
  //indicats whether the shop info will be shown or not
  final bool displayFromShop;

  final _messageController = TextEditingController();

  ProductDetails({
    Key key,
    this.displayFromShop = false,
    this.product,
  }) : super(key: key);

  static List<String> _quickResponses = [
    "Is it still available",
    "How much this product",
    "hello",
    "Good morning",
    "I am interested"
  ];

  List<Widget> _productImages() {
    List<Widget> images = [];
    for (String imageUrl in product.images) {
      images.add(
        CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: imageUrl,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      );
    }
    return images;
  }

  @override
  Widget build(BuildContext context) {
    final _productsController = context.watch<CustomerController>();
    final _addingToFavorite =
        _productsController.addingFavoriteId == product.id;
    final size = MediaQuery.of(context).size;
    final _dbService = DBService();
    Shop shop;
    return Scaffold(
      backgroundColor: colorBgLight,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      //product image
                      height: size.height * 0.25,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(radiusStandard),
                          bottomRight: Radius.circular(radiusStandard),
                        ),
                        child: InkWell(
                          onTap: () => Navigator.of(context).pushNamed(
                              ImagePreview.ROUTE_NAME,
                              arguments: product.images),
                          child: PageView(
                            scrollDirection: Axis.horizontal,
                            children: _productImages(),
                          ),
                        ),
                      ),
                    ),
                    displayFromShop
                        ? SizedBox()
                        : SizedBox(
                            //shop name rating container
                            child: FutureBuilder(
                              future: _dbService.getShop(product.shopId),
                              builder: (ctx, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.active ||
                                    snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                  return Padding(
                                    padding: const EdgeInsets.all(marginLarge),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: Text("error fetching shop data :("),
                                  );
                                }
                                shop = snapshot.data;
                                return ShopNameRating(
                                  onShopPressed: () => Navigator.of(context)
                                      .pushNamed(ShopPublicProfile.ROUTE_NAME,
                                          arguments: shop),
                                  shopLogo: shop.logo,
                                  shopName: shop.name,
                                  rate: shop.rate,
                                );
                              },
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(marginStandard),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                //product name
                                child: Text(
                                  product.name,
                                  style: TextStyle(
                                    fontSize: fontSizeMedium,
                                    color: colorPrimaryDark,
                                  ),
                                ),
                              ),
                              Text(product.price.toString()),
                            ],
                          ),
                          SizedBox(height: marginStandard),
                          Row(
                            children: [
                              Expanded(
                                //category label
                                child: Text(
                                  product.category,
                                  style: TextStyle(
                                    fontSize: fontSizeStandard,
                                    color: colorPrimary,
                                  ),
                                ),
                              ),
                              _addingToFavorite
                                  ? CircularProgressIndicator()
                                  : InkWell(
                                      //add to favortie icon
                                      onTap: () => _productsController
                                          .toggleFavorite(product.id),
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        child: _productsController
                                                .isFavoriteProduct(product.id)
                                            ? Icon(
                                                Icons.favorite,
                                                color: colorPrimaryDark,
                                              )
                                            : Icon(
                                                Icons.favorite_border,
                                                color: colorPrimaryDark,
                                              ),
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(height: marginLarge),
                          Text(
                            //product description
                            product.description,
                            style: TextStyle(
                              color: colorPrimary,
                              fontSize: fontSizeStandard,
                            ),
                          ),
                          Visibility(
                            visible: !displayFromShop,
                            child: StaticMap(
                              shop: shop,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            displayFromShop
                ? SizedBox()
                : Column(
                    children: [
                      Container(
                        //quick responses container
                        height: 50,
                        padding: const EdgeInsets.symmetric(
                          horizontal: marginStandard,
                          vertical: marginSmall,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: marginSmall,
                        ),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _quickResponses.length,
                            itemBuilder: (ctx, index) {
                              return Container(
                                //quick message container
                                margin: const EdgeInsets.symmetric(
                                  horizontal: marginSmall,
                                  vertical: marginSmall,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: marginStandard,
                                  vertical: marginSmall,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      radiusStandard,
                                    ),
                                  ),
                                  color: colorPrimaryLight,
                                ),
                                child: InkWell(
                                  onTap: () => _messageController.text =
                                      _quickResponses[index],
                                  child: Center(
                                    child: Text(_quickResponses[index]),
                                  ),
                                ),
                              );
                            }),
                      ),
                      Container(
                        //send message container
                        margin: const EdgeInsets.symmetric(
                          horizontal: marginStandard,
                          vertical: marginSmall,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              radiusStandard,
                            ),
                          ),
                          color: colorPrimaryLight,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: marginStandard,
                                ),
                                child: TextField(
                                  controller: _messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText: "Write a message",
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: StandardButton(
                                colorEnabled: colorPrimary,
                                text: "Send",
                                textStyle: TextStyle(color: colorPrimaryLight),
                                onButtonPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
