import 'package:flutter/material.dart';
import 'package:organik/constants.dart';

class ListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isHintText;
  final bool editMode;
  final bool noTrailingIcon;
  final Function onTap;

  const ListItem(
      {Key key,
      @required this.icon,
      @required this.text,
      @required this.onTap,
      this.editMode = false,
      this.isHintText = false,
      this.noTrailingIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        marginSmall,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: marginStandard,
        vertical: marginSmall,
      ),
      decoration: BoxDecoration(
        color: colorPrimaryLight,
        borderRadius: BorderRadius.all(
          Radius.circular(
            radiusStandard,
          ),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              child: Icon(
                icon,
                color: colorPrimary,
              ),
            ),
            SizedBox(
              width: marginStandard,
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: isHintText ? colorPrimary : colorPrimaryDark,
                ),
              ),
            ),
            noTrailingIcon
                ? SizedBox()
                : editMode
                    ? Icon(
                        Icons.edit_outlined,
                        color: colorPrimary,
                      )
                    : Icon(
                        Icons.arrow_forward_ios,
                        color: colorPrimary,
                      ),
          ],
        ),
      ),
    );
  }
}
