import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:organik/constants.dart';
import 'package:organik/widgets/button_standard.dart';
import 'package:organik/widgets/input_standard.dart';

class UpdateFieldDialog extends StatelessWidget {
  final String hintText;
  final String initialText;
  final bool isRequiredInput;

  const UpdateFieldDialog({
    Key key,
    this.hintText,
    this.initialText,
    this.isRequiredInput = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var field = initialText;
    return Container(
      padding: const EdgeInsets.all(marginStandard),
      decoration: BoxDecoration(
        color: colorPrimaryLight,
        borderRadius: BorderRadius.circular(radiusStandard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            //close button
            padding: const EdgeInsets.all(marginSmall),
            child: InkWell(
              onTap: () => Navigator.of(context).pop(null),
              child: Icon(Icons.close_rounded),
            ),
          ),
          StandardInput(
            hintText: hintText,
            initialValue: initialText != null ? initialText : "",
            isRequiredInput: isRequiredInput,
            color: colorBgLight,
            onChanged: (val) => field = val,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StandardButton(
                text: "btn_cancel".tr(),
                onButtonPressed: () => Navigator.of(context).pop(null),
              ),
              StandardButton(
                text: "btn_submit".tr(),
                onButtonPressed: () => Navigator.of(context).pop(field),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
