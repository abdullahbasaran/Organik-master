import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';

enum UserType { CUSTOMER, SHOP }

const colorPrimaryDark = Color(0xFF046425);
const colorPrimary = Color(0xFFA4C396);
const colorPrimaryLight = Color(0xFFDAEBD2);
const colorButtonEnabled = Color(0xFFF8B34B);
const colorButtonDisabled = Color(0xFFF8D49C);
const colorAccent = Color(0xFFF8D49C);
const colorBgDark = Color(0xFFA4C396);
const colorBgLight = Color(0xFFF0F8EC);

const marginSmall = 6.0;
const marginStandard = 12.0;
const marginLarge = 24.0;

const fontSizeSmall = 12.0;
const fontSizeStandard = 16.0;
const fontSizeMedium = 24.0;
const fontSizeLarge = 36.0;

const langEnCode = "en";
const langTrCode = "tr";

const radiusStandard = 16.0;
const radiusLarge = 24.0;

const MAX_WIDTH = 450.0;

const IMG_LOGO = "assets/images/logo.png";
const IMG_PERSON = "assets/images/ic_person.png";
const IMG_CART = "assets/images/ic_cart.png";

const CameraPosition INITIAL_CAMERA_POSITION = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);
