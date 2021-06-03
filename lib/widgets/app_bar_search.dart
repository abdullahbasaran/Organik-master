import 'package:flutter/material.dart';
import 'package:organik/constants.dart';
import 'package:organik/widgets/search_bar.dart';

class SearchAppBar extends StatelessWidget {
  final TextEditingController controller;
  final Function onActionTap;
  final ValueSetter<String> onSearchChange;

  const SearchAppBar(
      {Key key,
      @required this.onActionTap,
      this.onSearchChange,
      this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: marginStandard,
          right: marginStandard,
          bottom: marginLarge,
          top: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(radiusLarge),
            bottomRight: Radius.circular(radiusLarge)),
        color: colorPrimary,
      ),
      child: Row(
        children: [
          Expanded(
            child: SearchBar(
              controller: controller,
              onChanged: onSearchChange,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: marginSmall),
            padding: const EdgeInsets.all(marginStandard),
            decoration: BoxDecoration(
              color: colorPrimaryLight,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: onActionTap,
              child: Center(
                child: Icon(
                  Icons.gps_fixed,
                  color: colorPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
