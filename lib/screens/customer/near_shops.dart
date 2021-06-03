import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:organik/constants.dart';
import 'package:organik/models/product_category.dart';
import 'package:organik/models/shop.dart';
import 'package:organik/screens/customer/shop_public_profile.dart';
import 'package:organik/services/database_service.dart';
import 'package:organik/services/geolocator_service.dart';
import 'package:organik/utils/dialog_util.dart';
import 'package:organik/widgets/item_grid.dart';
import 'package:organik/widgets/item_shop_card.dart';
import 'package:rubber/rubber.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:organik/widgets/app_bar_search.dart';

class NearShops extends StatefulWidget {
  static const ROUTE_NAME = "MapScreen";

  @override
  _NearShopsState createState() => _NearShopsState();
}

class _NearShopsState extends State<NearShops>
    with SingleTickerProviderStateMixin {
  static const TAG = "NearShops:";
  static const CAT_MAX_WIDTH = 150.0;
  final _dbService = DBService();
  final Completer<GoogleMapController> _compController = Completer();
  final _geoService = GeolocatorService();
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  RubberAnimationController _rubberController;
  GoogleMapController _mapController;
  Position _currentPosition;
  Set<Marker> _shopMarkers = {};
  List<Shop> _shops = [];
  List<Shop> _filteredShops = [];

  var _headerHight = 70.0;
  var _bottomSheetEnabled = true;

  @override
  void initState() {
    print("$TAG initState called");
    _rubberController = RubberAnimationController(
        vsync: this,
        halfBoundValue: AnimationControllerValue(percentage: 0.5),
        duration: Duration(milliseconds: 200));
    _initCustomMarker();
    _fetchShops();
    _requestLocationPermission();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("$TAG didChangeDependencies called");
    super.didChangeDependencies();
  }

  void _fetchShops() async {
    print("$TAG fetching shops..");
    _shops = await _dbService.getAllShops();
  }

  void _requestLocationPermission() {
    print("$TAG requesting location permission from user..");
    _geoService
        .checkLocationPermission()
        .then((value) => _currentPosition = value)
        .catchError((error) {
      // DialogUtil.showAlertDialog(context, error.toString());
    });
  }

  void _locatePosition(Position position) async {
    print("$TAG moving camera to $position");
    if (position != null) {
      final LatLng latLngPosition =
          LatLng(position.latitude, position.longitude);
      final CameraPosition cameraPosition =
          CameraPosition(target: latLngPosition, zoom: 14);
      _mapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    } else {
      _requestLocationPermission();
    }
  }

  void _moveCameraTo(GeoPoint geoPoint) {
    if (geoPoint != null) {
      final LatLng latLngPosition =
          LatLng(geoPoint.latitude, geoPoint.longitude);
      final CameraPosition cameraPosition =
          CameraPosition(target: latLngPosition, zoom: 11);
      _mapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    } else {
      DialogUtil.showToast("error_getting_shop_location".tr());
    }
  }

  void _onInfoMarkerPressed(String shopId) {
    print("$TAG info window marker pressed for shop $shopId");
  }

  void _filterShopsByCategory(String category) {
    print("$TAG filtering shops by $category");
    setState(() {
      _searchController.text = "";
      _filteredShops =
          _shops.where((shop) => shop.categories.contains(category)).toList();
    });
    print(
        "$TAG shops by category: $category = [${_filteredShops.map((e) => e.id)}]");

    _reflectChanges();
    _updateShopsMarkers(_filteredShops);
    if (_filteredShops.length == 0)
      DialogUtil.showToast("msg_no_shops_for_selected_category".tr());
  }

  void _serachShopsByNameOrProductName(String input) {
    print("$TAG searching for $input");
    setState(() {
      if (input.isEmpty) {
        //clear the list when the input is empty
        //to reflect changes on other widgets
        _filteredShops = [];
        return;
      }
      _filteredShops = _shops
          .where((shop) =>
              shop.name.contains(input) || shop.categories.contains(input))
          .toList();
    });
    _reflectChanges();
    _updateShopsMarkers(_filteredShops);
    print("$TAG shops by input: $input = [${_filteredShops.map((e) => e.id)}]");
  }

  void _reflectChanges() {
    final count = _filteredShops.length;
    setState(() {});
  }

  void _initCustomMarker() {
    print("$TAG init custom marker");
  }

  void _updateShopsMarkers(List<Shop> shops) {
    print('$TAG updating shop markers..');
    print('$TAG all markers = ${shops.length}');
    if (shops.length == 0) {
      _shopMarkers = {};
      return;
    }
    for (Shop shop in shops) {
      if (shop.geoPoint != null) {
        Marker marker = Marker(
          markerId: MarkerId(shop.id),
          position: LatLng(shop.geoPoint?.latitude, shop.geoPoint?.longitude),
          infoWindow: InfoWindow(
            title: shop.name,
            snippet: shop.rate.toString(),
            onTap: () => _onInfoMarkerPressed(shop.id),
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          onTap: () {},
        );
        _shopMarkers.add(marker);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    print("$TAG shops length ${_filteredShops.length}");
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SearchAppBar(
                controller: _searchController,
                onActionTap: () => _locatePosition(_currentPosition),
                onSearchChange: (input) =>
                    _serachShopsByNameOrProductName(input),
              ),
              // Spacer(),
              Expanded(
                child: RubberBottomSheet(
                  scrollController: _scrollController,
                  lowerLayer: _getLowerLayer(),
                  header: _getHeader(),
                  headerHeight: _headerHight,
                  upperLayer: _getUpperLayer(),
                  animationController: _rubberController,
                ),
              ),
            ],
          ),
          _filteredShops.length == 0
              ? SizedBox()
              : Positioned(
                  bottom: marginStandard,
                  height: _size.height * 0.35,
                  width: _size.width,
                  child: Container(
                    // height: _size.height * 0.3,
                    width: _size.width,
                    // color: Colors.red,
                    child: ListView.builder(
                      itemCount: _filteredShops.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return ShopCardItem(
                          shop: _filteredShops[index],
                          onVisitShopPressed: () =>
                              Navigator.of(context).pushNamed(
                            ShopPublicProfile.ROUTE_NAME,
                            arguments: _filteredShops[index],
                          ),
                          onCardPressed: () {
                            _moveCameraTo(_filteredShops[index].geoPoint);
                          },
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _getLowerLayer() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: INITIAL_CAMERA_POSITION,
      compassEnabled: false,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      markers: _shopMarkers,
      onLongPress: (_) {
        setState(() {
          _filteredShops = [];
          _updateShopsMarkers(_filteredShops);
          _locatePosition(_currentPosition);
        });
      },
      onMapCreated: (GoogleMapController controller) {
        if (!_compController.isCompleted) _compController.complete(controller);
        _mapController = controller;
        _locatePosition(_currentPosition);
      },
    );
  }

  ///returns the categories bottom sheet
  Widget _getUpperLayer() {
    final _size = MediaQuery.of(context).size;
    return _filteredShops.length > 0
        ? Container(
            // height: 150,
            // color: Colors.red,
            )
        : Container(
            padding: const EdgeInsets.all(marginStandard),
            decoration: BoxDecoration(color: colorPrimaryLight),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _size.width ~/ CAT_MAX_WIDTH,
                crossAxisSpacing: marginLarge,
                mainAxisSpacing: marginLarge,
              ),
              physics: NeverScrollableScrollPhysics(),
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                return GridItem(
                  onTap: () => _filterShopsByCategory(categories[index + 1].id),
                  color: colorBgLight,
                  text: categories[index + 1].nameEn,
                  svg: categories[index + 1].image,
                );
              },
              itemCount: categories.length - 1,
            ),
          );
  }

  ///returns the header of the bottom sheet
  Widget _getHeader() {
    final _size = MediaQuery.of(context).size;
    return _filteredShops.length > 0
        ? SizedBox()
        : Flexible(
            child: Container(
              width: _size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusStandard),
                  topRight: Radius.circular(radiusStandard),
                ),
                color: colorPrimaryLight,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: _size.width * 0.3,
                      height: 4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(marginStandard),
                    width: _size.width,
                    child: Text(
                      "What are you looking for ?",
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
