import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:organik/constants.dart';

import 'button_lang.dart';

class LangPicker extends StatelessWidget {
  final bool popOnTap;

  const LangPicker({Key key, this.popOnTap = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          LangButton(
            isSelected: context.locale == Locale(langTrCode),
            text: "Turkish",
            onPressed: () {
              context.setLocale(Locale(langTrCode));
              if (popOnTap) Navigator.of(context).pop();
            },
          ),
          LangButton(
            isSelected: context.locale == Locale(langEnCode),
            text: "English",
            onPressed: () {
              context.setLocale(Locale(langEnCode));
              if (popOnTap) Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
