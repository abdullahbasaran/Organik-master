import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:organik/constants.dart';
import 'package:organik/providers/customer_controller.dart';
import 'package:organik/providers/shop_controller.dart';
import 'package:organik/screens/auth_wrapper.dart';
import 'package:organik/screens/authentication/account_type_picker.dart';
import 'package:organik/screens/authentication/register_screen.dart';
import 'package:organik/screens/customer/home_screen.dart';
import 'package:organik/screens/customer/near_shops.dart';
import 'package:organik/screens/customer/my_profile.dart';
import 'package:organik/screens/customer/product_details.dart';
import 'package:organik/screens/customer/shop_public_profile.dart';
import 'package:organik/screens/image_preview.dart';
import 'package:organik/screens/shop/add_update_product.dart';
import 'package:organik/screens/shop/home.dart';
import 'package:organik/screens/shop/pick_location.dart';
import 'package:organik/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale(langEnCode, ""),
        Locale(langTrCode, ""),
      ],
      path: "assets/languages",
      fallbackLocale: Locale(langEnCode),
      saveLocale: true,
      // fallbackLocale: Locale('en', 'US'),
      // startLocale: Locale('de', 'DE'),
      // saveLocale: false,
      useOnlyLangCode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProxyProvider<AuthService, ShopController>(
            update: (context, auth, previousState) =>
                previousState..update(auth),
            create: (BuildContext context) => ShopController(),
          ),
          ChangeNotifierProxyProvider<AuthService, CustomerController>(
            update: (context, auth, previousState) =>
                previousState..update(auth),
            create: (BuildContext context) => CustomerController(),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ORGANIK',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Maiandra",
        primaryColor: colorPrimary,
        primaryColorDark: colorPrimaryDark,
        primaryColorLight: colorPrimaryLight,
        accentColor: colorAccent,
        buttonColor: colorButtonEnabled,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: context.localizationDelegates,
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: AuthWrapper(),
      routes: {
        AccountTypePicker.ROUTE_NAME: (_) => AccountTypePicker(),
        RegisterAccountScreen.ROUTE_NAME: (_) => RegisterAccountScreen(),
        ProductDetails.ROUTE_NAME: (_) => ProductDetails(),
        NearShops.ROUTE_NAME: (_) => NearShops(),
        ShopHome.ROUTE_NAME: (_) => ShopHome(),
        AddUpdateProduct.ROUTE_NAME: (_) => AddUpdateProduct(),
        CustomerHome.ROUTE_NAME: (_) => CustomerHome(),
        ProfileScreen.ROUTE_NAME: (_) => ProfileScreen(),
        ShopPublicProfile.ROUTE_NAME: (_) => ShopPublicProfile(),
        PickLocationMap.ROUTE_NAME: (_) => PickLocationMap(),
        ImagePreview.ROUTE_NAME: (_) => ImagePreview(),
      },
    );
  }
}
