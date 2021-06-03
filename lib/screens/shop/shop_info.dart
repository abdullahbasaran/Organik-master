import 'dart:async';

import 'package:flutter/material.dart';
import 'package:organik/models/shop.dart';
import 'package:organik/providers/shop_controller.dart';
import 'package:organik/screens/shop/pick_location.dart';
import 'package:organik/utils/dialog_util.dart';
import 'package:organik/widgets/static_map.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:organik/constants.dart';
import 'package:organik/widgets/item_list.dart';
import 'package:easy_localization/easy_localization.dart';

class ShopInfo extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final _shopController = context.watch<ShopController>();
    final _shop = _shopController.shop;
    final _isLoading = _shopController.isLoading;
    final Set<Marker> _shopLocationMarker = {
      if (_shop?.geoPoint != null)
        Marker(
          markerId: MarkerId(_shop.id),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: LatLng(_shop.geoPoint.latitude, _shop.geoPoint.longitude),
        )
    };
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          marginStandard,
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ListItem(
                      icon: Icons.title_rounded,
                      text: _shop?.name != null && _shop.name.isNotEmpty
                          ? _shop.name
                          : "hint_shop_name".tr(),
                      editMode: true,
                      isHintText: _shop?.name == null || _shop.name.isEmpty,
                      onTap: () async {
                        final result = await DialogUtil.showUpdateField(
                          context,
                          hintText: "hint_shop_name".tr(),
                          initialText: _shop?.name,
                        );
                        if (result != null && result != _shop.name) {
                          await DialogUtil.showToast("Updating field..");
                          _shopController.updateProfileField(
                              Shop.DB_FIELD_NAME, result);
                        }
                      },
                    ),
                    ListItem(
                      icon: Icons.description_rounded,
                      text: _shop?.bio != null && _shop.bio.isNotEmpty
                          ? _shop.bio
                          : "hint_bio".tr(),
                      editMode: true,
                      isHintText: _shop?.bio == null || _shop.bio.isEmpty,
                      onTap: () {},
                    ),
                    ListItem(
                      icon: Icons.public_rounded,
                      text: _shop?.website != null && _shop.website.isNotEmpty
                          ? _shop.website
                          : "hint_website".tr(),
                      editMode: true,
                      isHintText:
                          _shop?.website == null || _shop.website.isEmpty,
                      onTap: () async {
                        final result = await DialogUtil.showUpdateField(
                          context,
                          hintText: "hint_website".tr(),
                          initialText: _shop?.website,
                        );
                        if (result != null && result != _shop.website) {
                          await DialogUtil.showToast("Updating field..");
                          _shopController.updateProfileField(
                              Shop.DB_FIELD_WEBSITE, result);
                        }
                      },
                    ),
                    ListItem(
                      icon: Icons.schedule_rounded,
                      text: _shop?.workingHours != null &&
                              _shop.workingHours.isNotEmpty
                          ? _shop.workingHours.toString()
                          : "hint_working_hours".tr(),
                      editMode: true,
                      isHintText: _shop?.workingHours == null ||
                          _shop.workingHours.isEmpty,
                      onTap: () {},
                    ),
                    ListItem(
                      icon: Icons.call_rounded,
                      text: _shop?.phoneNumber != null &&
                              _shop.phoneNumber.isNotEmpty
                          ? _shop.phoneNumber
                          : "hint_phone_number".tr(),
                      editMode: true,
                      isHintText: _shop?.phoneNumber == null ||
                          _shop.phoneNumber.isEmpty,
                      onTap: () async {
                        final result = await DialogUtil.showUpdateField(
                          context,
                          hintText: "hint_phone_number".tr(),
                          initialText: _shop?.phoneNumber,
                        );
                        if (result != null && result != _shop.phoneNumber) {
                          await DialogUtil.showToast("Updating field..");
                          _shopController.updateProfileField(
                              Shop.DB_FIELD_PHONE, result);
                        }
                      },
                    ),
                    ListItem(
                      icon: Icons.domain_rounded,
                      text: _shop?.address != null && _shop.address.isNotEmpty
                          ? _shop.address
                          : "hint_address".tr(),
                      editMode: true,
                      isHintText:
                          _shop?.address == null || _shop.address.isEmpty,
                      onTap: () async {
                        final result = await DialogUtil.showUpdateField(
                          context,
                          hintText: "hint_address".tr(),
                          initialText: _shop?.address,
                        );
                        if (result != null && result != _shop.address) {
                          await DialogUtil.showToast("Updating field..");
                          _shopController.updateProfileField(
                              Shop.DB_FIELD_ADDRESS, result);
                        }
                      },
                    ),
                    ListItem(
                      icon: Icons.local_offer_rounded,
                      text: _shop?.categories != null &&
                              _shop.categories.isNotEmpty
                          ? _shop.categories.toString()
                          : "hint_categories".tr(),
                      editMode: true,
                      isHintText:
                          _shop?.categories == null || _shop.categories.isEmpty,
                      onTap: () {},
                    ),
                    StaticMap(
                      shop: _shop,
                      onMapPressed: () => Navigator.pushNamed(
                        context,
                        PickLocationMap.ROUTE_NAME,
                      ),
                      displayForShop: true,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
