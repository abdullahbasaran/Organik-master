import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:organik/constants.dart';

class EmptyShopMessage extends StatelessWidget {
  final Function onTap;

  const EmptyShopMessage({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/empty_shop.svg",
            color: colorPrimary,
            width: _size.width * 0.45,
          ),
          SizedBox(
            height: marginLarge,
          ),
          Text(
            "You don’t have any product yet Add one now",
            style: TextStyle(color: colorPrimary, fontSize: fontSizeStandard),
          ),
          SizedBox(
            height: marginStandard,
          ),
          TextButton(
            onPressed: onTap,
            child: Icon(
              Icons.add_circle_outline,
              color: colorPrimary,
              size: _size.width * 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
