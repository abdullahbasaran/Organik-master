import 'dart:async';

import 'package:flutter/material.dart';
import 'package:organik/constants.dart';
import 'package:organik/utils/dialog_util.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:organik/providers/shop_controller.dart';
import 'package:organik/widgets/app_bar_standard.dart';

class PickLocationMap extends StatelessWidget {
  static const ROUTE_NAME = "PickLocationMap:";

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final _shopController = context.watch<ShopController>();
    final _shop = _shopController.shop;

    return Scaffold(
      body: Column(
        children: [
          StandardAppBar(
            title: "Update my location",
            actionIcon: Icons.done,
            onActionPressed: () async {
              await _shopController
                  .updateShopLocation(_shopController.pickedLatLng)
                  .catchError((error) {
                DialogUtil.showToast(error.toString());
                return;
              });
              DialogUtil.showToast("Updated shop location");
              Navigator.of(context).pop();
            },
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: INITIAL_CAMERA_POSITION,
              markers: _shopController.pickedMarker,
              onTap: (latLng) => _shopController.updatePickedMarker(latLng),
              onMapCreated: (GoogleMapController controller) {
                if (!_controller.isCompleted) _controller.complete(controller);
                if (_shop?.geoPoint != null) {
                  controller.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(
                          _shop.geoPoint.latitude,
                          _shop.geoPoint.longitude,
                        ),
                        zoom: 14,
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
