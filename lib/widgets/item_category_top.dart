import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:organik/constants.dart';

class CategoryTopItem extends StatelessWidget {
  final Function onTap;
  final String text;
  final String image;
  final bool isSelected;

  const CategoryTopItem(
      {Key key, this.onTap, this.text, this.image, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      padding:
          const EdgeInsets.symmetric(horizontal: marginSmall, vertical: 2.0),
      margin: const EdgeInsets.symmetric(
          horizontal: marginStandard, vertical: marginSmall),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorPrimaryLight,
          border: Border.all(
              width: 1, color: isSelected ? colorPrimaryDark : colorPrimary)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(marginSmall),
              child: Column(
                children: [
                  Container(
                    child: SvgPicture.asset(
                      image,
                      width: 35,
                      height: 35,
                      color: colorPrimaryDark,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      text,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: fontSizeSmall,
                        color: colorPrimaryDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
