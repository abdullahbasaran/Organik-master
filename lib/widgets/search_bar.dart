import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../constants.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueSetter<String> onChanged;

  const SearchBar({Key key, @required this.onChanged, this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorPrimaryLight,
        borderRadius: BorderRadius.all(
          Radius.circular(radiusStandard),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: marginStandard, vertical: marginSmall),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: colorPrimary,
            ),
            SizedBox(
              width: marginStandard,
            ),
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "label_search".tr(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
