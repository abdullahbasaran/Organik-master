import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:organik/constants.dart';
import 'package:organik/widgets/dialog_reset_password.dart';
import 'package:organik/widgets/dialog_update_field.dart';
import 'package:organik/widgets/lang_picker.dart';

class DialogUtil {
  static Future<void> showResetPasswordDialog(
      BuildContext context, String email) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: ResetpasswordDialog(
            email: email,
          ),
        );
      },
    );
  }

  static Future<void> showLangPickerDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(marginStandard),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusStandard),
                color: colorBgLight),
            child: LangPicker(
              popOnTap: true,
            ),
          ),
        );
      },
    );
  }

  static Future<String> showUpdateField(BuildContext context,
      {String hintText, String initialText, bool isRequiredInput}) {
    return showDialog<String>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: UpdateFieldDialog(
            hintText: hintText,
            initialText: initialText,
            isRequiredInput: isRequiredInput,
          ),
        );
      },
    );
  }

  static Future<bool> showToast(String message,
      {Toast length = Toast.LENGTH_SHORT,
      ToastGravity gravity = ToastGravity.BOTTOM}) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: gravity,
      backgroundColor: colorPrimaryLight,
      textColor: colorPrimaryDark,
      fontSize: 16.0,
    );
  }
}
