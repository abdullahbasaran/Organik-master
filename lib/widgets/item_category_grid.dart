import 'package:flutter/material.dart';
import 'package:organik/constants.dart';

class CategoryGridItem extends StatelessWidget {

  final Function onTap;
  final String text;
  final String image;

  CategoryGridItem({@required this.text, @required this.image, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _width = _size.width / 2 - marginStandard * 2;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: _width,
        height: _width,
        padding: EdgeInsets.all(marginStandard),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radiusStandard),),
          color: colorPrimaryLight,
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: Image.asset(image, fit: BoxFit.scaleDown,),
              ),
            ),
            Text(text, style: TextStyle(fontSize: fontSizeStandard, color: colorPrimaryDark),),
          ],
        ),
      ),
    );
  }
}
