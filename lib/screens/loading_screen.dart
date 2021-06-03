import 'package:flutter/material.dart';
import 'package:organik/constants.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(IMG_LOGO),
            SizedBox(
              height: marginLarge,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
