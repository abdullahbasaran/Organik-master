import 'package:flutter/material.dart';
import 'package:organik/constants.dart';

class LangButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final bool isSelected;

  LangButton({@required this.text, @required this.isSelected, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radiusStandard),),
        color: isSelected ? colorPrimaryDark : colorPrimaryLight,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radiusStandard),),
        child: TextButton(
          onPressed: onPressed,
          child: Text(text, style: TextStyle(color: isSelected ? colorPrimaryLight : colorPrimaryDark),),
        ),
      ),
    );
  }
}
