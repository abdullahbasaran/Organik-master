import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:organik/models/user.dart';
import 'package:organik/screens/authentication/login_screen.dart';
import 'package:organik/screens/customer/home_screen.dart';
import 'package:organik/screens/loading_screen.dart';
import 'package:organik/screens/shop/home.dart';
import 'package:organik/services/auth_service.dart';
import 'package:organik/services/database_service.dart';

class AuthWrapper extends StatelessWidget {
  static const TAG = "AuthWrapper:";
  final _authSerive = AuthService();
  final _dbService = DBService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: _authSerive.authChangeStream(),
      builder: (ctx, snapshot) {
        print("$TAG called stream builder");
        if (snapshot.connectionState != ConnectionState.active) {
          return LoadingScreen();
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("error_retrieving_data".tr()),
          );
        }
        if (snapshot.hasData) {
          print("$TAG snapshot has data");
          final user = snapshot.data;

          if (user != null) {
            print("$TAG user not null");
            return FutureBuilder<MyUser>(
                future: _dbService.getUserData(user),
                builder: (ctx, snapshot) {
                  print("$TAG called future builder");
                  if (snapshot.connectionState == ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingScreen();
                  }

                  final MyUser myUser = snapshot.data;

                  if (myUser.isCustomer()) {
                    print("$TAG current user type is customer");
                    return CustomerHome();
                  }
                  if (myUser.isShop()) {
                    print("$TAG current user type is shop");
                    return ShopHome();
                  }
                  print("$TAG error retrieving user data");
                  return Center(
                    child: Text("error_retrieving_user_data".tr()),
                  );
                });
          }
        }
        print("$TAG user stream null");
        return LoginScreen();
      },
    );
  }
}
