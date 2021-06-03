import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:organik/constants.dart';

class NoProductMessage extends StatelessWidget {
  final Function onTap;

  const NoProductMessage({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/no_product.svg",
            color: colorPrimary,
            width: _size.width * 0.45,
          ),
          SizedBox(
            height: marginLarge,
          ),
          Text(
            "msg_no_product_for_selected_category".tr(),
            style: TextStyle(color: colorPrimary, fontSize: fontSizeStandard),
          ),
        ],
      ),
    );
  }
}
