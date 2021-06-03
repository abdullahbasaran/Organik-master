import 'package:flutter/material.dart';
import 'package:organik/models/shop.dart';
import 'package:organik/services/database_service.dart';
import 'package:organik/constants.dart';
import 'package:organik/widgets/item_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:organik/widgets/static_map.dart';

class ShopInfo extends StatelessWidget {
  final _dbService = DBService();

  final String shopId;

  ShopInfo({Key key, this.shopId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          marginStandard,
        ),
        child: FutureBuilder<Shop>(
            future: _dbService.getShop(shopId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(child: Text("error_retrieving_data".tr()));
              }
              if (!snapshot.hasData) {
                return Center(child: Text("error_retrieving_data".tr()));
              }
              final _shop = snapshot.data;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListItem(
                      icon: Icons.title_rounded,
                      text: _shop?.name != null && _shop.name.isNotEmpty
                          ? _shop.name
                          : "hint_shop_name".tr(),
                      noTrailingIcon: true,
                      isHintText: _shop?.name == null || _shop.name.isEmpty,
                      onTap: null,
                    ),
                    ListItem(
                      icon: Icons.description_rounded,
                      text: _shop?.bio != null && _shop.bio.isNotEmpty
                          ? _shop.bio
                          : "hint_bio".tr(),
                      noTrailingIcon: true,
                      isHintText: _shop?.bio == null || _shop.bio.isEmpty,
                      onTap: null,
                    ),
                    ListItem(
                      icon: Icons.public_rounded,
                      text: _shop?.website != null && _shop.website.isNotEmpty
                          ? _shop.website
                          : "hint_website".tr(),
                      noTrailingIcon: true,
                      isHintText:
                          _shop?.website == null || _shop.website.isEmpty,
                      onTap: () {
                        // todo go to website
                      },
                    ),
                    ListItem(
                      icon: Icons.schedule_rounded,
                      text: _shop?.workingHours != null &&
                              _shop.workingHours.isNotEmpty
                          ? _shop.workingHours.toString()
                          : "hint_working_hours".tr(),
                      noTrailingIcon: true,
                      isHintText: _shop?.workingHours == null ||
                          _shop.workingHours.isEmpty,
                      onTap: null,
                    ),
                    ListItem(
                      icon: Icons.call_rounded,
                      text: _shop?.phoneNumber != null &&
                              _shop.phoneNumber.isNotEmpty
                          ? _shop.phoneNumber
                          : "hint_phone_number".tr(),
                      noTrailingIcon: true,
                      isHintText: _shop?.phoneNumber == null ||
                          _shop.phoneNumber.isEmpty,
                      onTap: () {
                        //todo make phone call
                      },
                    ),
                    ListItem(
                      icon: Icons.domain_rounded,
                      text: _shop?.address != null && _shop.address.isNotEmpty
                          ? _shop.address
                          : "hint_address".tr(),
                      noTrailingIcon: true,
                      isHintText:
                          _shop?.address == null || _shop.address.isEmpty,
                      onTap: null,
                    ),
                    ListItem(
                      icon: Icons.local_offer_rounded,
                      text: _shop?.categories != null &&
                              _shop.categories.isNotEmpty
                          ? _shop.categories.toString()
                          : "hint_categories".tr(),
                      noTrailingIcon: true,
                      isHintText:
                          _shop?.categories == null || _shop.categories.isEmpty,
                      onTap: null,
                    ),
                    StaticMap(
                      shop: _shop,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
