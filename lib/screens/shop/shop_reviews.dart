import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:organik/constants.dart';
import 'package:organik/models/review.dart';
import 'package:organik/services/database_service.dart';
import 'package:organik/widgets/item_review.dart';

class ShopReviews extends StatelessWidget {
  final String shopId;

  const ShopReviews({Key key, this.shopId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _dbService = DBService();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: marginStandard,
          vertical: marginSmall,
        ),
        child: FutureBuilder(
          future: _dbService.getShopReviews(shopId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.all(marginLarge),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("error_retrieving_data".tr()),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text("msg_you_dont_have_reviews_yet".tr()),
              );
            }
            List<Review> reviews = snapshot.data;

            if (reviews.length == 0) {
              return Center(
                child: Text("msg_you_dont_have_reviews_yet".tr()),
              );
            }
            return ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (ctx, index) {
                return ReviewItem(
                  review: reviews[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
