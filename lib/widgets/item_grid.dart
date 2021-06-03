import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organik/constants.dart';

class GridItem extends StatelessWidget {
  final Function onTap;
  final double width;
  final double height;
  final String text;
  final String image;
  final String svg;
  final Color color;

  GridItem(
      {@required this.text,
      this.image = '',
      @required this.onTap,
      this.width = 150,
      this.height = 150,
      this.color = colorPrimaryLight,
      this.svg = ''});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(marginStandard),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(radiusStandard),
          ),
          color: color,
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: image.isNotEmpty
                    ? Image.asset(
                        image,
                        fit: BoxFit.scaleDown,
                      )
                    : svg.isNotEmpty
                        ? SvgPicture.asset(
                            svg,
                            color: colorPrimary,
                            width: 80,
                            height: 80,
                          )
                        : Image.asset(""),
              ),
            ),
            Text(
              text,
              style: TextStyle(fontSize: fontSizeStandard, color: colorPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
