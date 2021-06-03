import 'package:flutter/material.dart';
import 'package:organik/constants.dart';

class StandardAppBar extends StatelessWidget {
  final String title;
  final IconData actionIcon;
  final Function onActionPressed;

  const StandardAppBar(
      {Key key, @required this.title, this.actionIcon, this.onActionPressed})
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
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: colorPrimaryLight,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: marginStandard),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: "ComicSans",
                  fontSize: fontSizeStandard,
                  color: colorPrimaryLight,
                ),
              ),
            ),
          ),
          Visibility(
            visible: actionIcon != null,
            child: TextButton(
              onPressed: onActionPressed,
              child: Icon(
                actionIcon ?? actionIcon,
                color: colorPrimaryLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
