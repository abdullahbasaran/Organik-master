import 'package:flutter/material.dart';
import 'package:organik/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:organik/screens/customer/near_shops.dart';

class HomeAppBar extends StatelessWidget {
  final bool customerAppBar;
  final Function onProfileClick;

  const HomeAppBar({Key key, this.customerAppBar = true, this.onProfileClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: marginStandard,
        right: marginStandard,
        bottom: marginLarge,
        top: 50,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(radiusLarge),
            bottomRight: Radius.circular(radiusLarge)),
        color: colorPrimary,
      ),
      child: Row(
        children: [
          Image.asset(IMG_LOGO),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: marginStandard),
              child: Text(
                "app_name".tr(),
                style: TextStyle(
                  fontFamily: "ComicSans",
                  fontSize: fontSizeMedium,
                  color: colorPrimaryDark,
                ),
              ),
            ),
          ),
          Visibility(
            visible: customerAppBar,
            child: Row(
              children: [
                InkWell(
                  onTap: () =>
                      Navigator.of(context).pushNamed(NearShops.ROUTE_NAME),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: marginSmall),
                    padding: const EdgeInsets.all(marginStandard),
                    decoration: BoxDecoration(
                      color: colorPrimaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.near_me_rounded,
                        color: colorPrimary,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: onProfileClick,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: marginSmall),
                    padding: const EdgeInsets.all(marginStandard),
                    decoration: BoxDecoration(
                      color: colorPrimaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        color: colorPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
