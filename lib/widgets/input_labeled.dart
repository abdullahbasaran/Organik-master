import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../constants.dart';

typedef StringFunction = String Function(String val);

class LabeledInput extends StatelessWidget {
  final TextEditingController controller;
  final StringFunction validator;
  final ValueSetter<String> onChanged;
  final ValueSetter<String> onDropItemSelected;
  final Color color;
  final String label;
  final String hint;
  final String initialValue;
  final bool isRequiredInput;
  final List<String> dropItems;

  const LabeledInput(
      {Key key,
      @required this.label,
      this.validator,
      this.onChanged,
      this.isRequiredInput = false,
      this.initialValue = "",
      this.color,
      this.onDropItemSelected,
      this.dropItems,
      this.hint,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: marginStandard,
        vertical: marginSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          SizedBox(
            height: marginSmall,
          ),
          Container(
            margin: EdgeInsets.only(bottom: marginSmall),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(radiusStandard),
              ),
              color: color != null ? color : colorPrimaryLight,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: marginStandard, vertical: marginSmall),
              child: Row(
                children: [
                  Expanded(
                    child: FocusScope(
                      node: FocusScopeNode(),
                      canRequestFocus: dropItems == null,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: hint,
                        ),
                        controller: controller,
                        //either initial value or controller can be used at the same time
                        initialValue: controller == null ? initialValue : null,
                        onChanged: (val) => onChanged(val),
                        cursorColor: colorAccent,
                        validator: validator != null
                            ? (value) => validator(value)
                            : (value) {
                                if (isRequiredInput && value.isEmpty) {
                                  return "error_empty_field".tr();
                                }
                                return null;
                              },
                      ),
                    ),
                  ),
                  dropItems == null
                      ? SizedBox()
                      : DropdownButton<String>(
                          dropdownColor:
                              color != null ? color : colorPrimaryLight,
                          items: dropItems.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: onDropItemSelected,
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
