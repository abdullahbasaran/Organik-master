import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:organik/constants.dart';

class AppHeader extends StatelessWidget {
  final bool bigHeader;

  const AppHeader({this.bigHeader = false});

  @override
  Widget build(BuildContext context) {
    return Row(

      ///logo widget
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(IMG_LOGO),
        SizedBox(
          width: marginStandard,
        ),
        Text(
          "app_name".tr(),
          style: TextStyle(
              fontFamily: "ComicSans",
              fontSize: bigHeader ? fontSizeLarge : fontSizeMedium,
              color: colorPrimaryDark),
        ),
      ],
    );
  }
}