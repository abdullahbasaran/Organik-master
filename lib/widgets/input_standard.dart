import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../constants.dart';

typedef StringFunction = String Function(String val);

class StandardInput extends StatelessWidget {
  final StringFunction validator;
  final ValueSetter<String> onChanged;
  final Color color;
  final String hintText;
  final String initialValue;
  final bool isRequiredInput;
  final bool isObscureText;
  final bool emailFormat;
  final int minLength;

  const StandardInput(
      {Key key,
      @required this.hintText,
      this.validator,
      this.onChanged,
      this.isRequiredInput = false,
      this.isObscureText = false,
      this.minLength = 0,
      this.emailFormat = false,
      this.initialValue = "",
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginLarge),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radiusStandard),
        ),
        color: color != null ? color : colorPrimaryLight,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: marginStandard, vertical: marginSmall),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: hintText,
          ),
          initialValue: initialValue,
          obscureText: isObscureText,
          onChanged: (val) => onChanged(val),
          cursorColor: colorAccent,
          validator: validator != null
              ? (value) => validator(value)
              : (value) {
                  if (isRequiredInput && value.isEmpty) {
                    return "error_empty_field".tr();
                  }
                  if (minLength > 0 && value.length < minLength) {
                    if (isObscureText) return "error_short_password".tr();
                    return "error_min_length_is $minLength".tr();
                  }
                  if (emailFormat && !EmailValidator.validate(value)) {
                    return "error_invalid_email_format".tr();
                  }
                  return null;
                },
        ),
      ),
    );
  }
}
