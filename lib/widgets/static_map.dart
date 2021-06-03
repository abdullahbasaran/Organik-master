import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:organik/constants.dart';
import 'package:organik/models/shop.dart';
import 'package:organik/screens/shop/pick_location.dart';

class StaticMap extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();
  final Shop shop;
  final Function onMapPressed;
  final bool displayForShop;

  StaticMap(
      {Key key, this.shop, this.onMapPressed, this.displayForShop = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Set<Marker> _shopLocationMarker = {
      if (shop?.geoPoint != null)
        Marker(
          markerId: MarkerId(shop.id),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: LatLng(shop.geoPoint.latitude, shop.geoPoint.longitude),
        )
    };
    return Container(
      //map container
      height: 200,
      margin: const EdgeInsets.symmetric(
        vertical: marginLarge,
        horizontal: marginStandard,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(
            radiusStandard,
          ),
        ),
        child: Stack(
          children: [
            GoogleMap(
              myLocationButtonEnabled: false,
              compassEnabled: false,
              rotateGesturesEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: INITIAL_CAMERA_POSITION,
              markers: _shopLocationMarker,
              onTap: (_) => Navigator.pushNamed(
                context,
                PickLocationMap.ROUTE_NAME,
              ),
              onMapCreated: (GoogleMapController controller) {
                if (!_controller.isCompleted) _controller.complete(controller);
                if (shop?.geoPoint != null) {
                  controller.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(
                          shop.geoPoint.latitude,
                          shop.geoPoint.longitude,
                        ),
                        zoom: 14,
                      ),
                    ),
                  );
                }
              },
            ),
            shop?.geoPoint != null
                ? SizedBox()
                : Container(
                    color: Color.fromRGBO(0, 0, 0, 90),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(marginStandard),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.not_listed_location_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: marginStandard,
                            ),
                            Flexible(
                              child: Text(
                                displayForShop
                                    ? "msg_you_dont_have_location".tr()
                                    : "msg_shop_has_no_location".tr(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
