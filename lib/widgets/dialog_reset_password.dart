import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import 'package:organik/constants.dart';
import 'package:organik/services/auth_service.dart';
import 'package:organik/widgets/button_standard.dart';
import 'package:organik/widgets/input_standard.dart';

class ResetpasswordDialog extends StatefulWidget {
  final String email;

  ResetpasswordDialog({Key key, this.email = ""}) : super(key: key);

  @override
  _ResetpasswordDialogState createState() => _ResetpasswordDialogState();
}

class _ResetpasswordDialogState extends State<ResetpasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  AuthService _authService;
  var _emailAddress = "";
  var _resetEmailSent = false;

  @override
  void didChangeDependencies() {
    _authService = context.watch<AuthService>();
    _emailAddress = widget.email;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.all(marginSmall),
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(Icons.close_rounded),
            ),
          ),
          Column(
            children: [
              _resetEmailSent
                  ? Padding(
                      padding: const EdgeInsets.all(marginStandard),
                      child: Center(
                        child: Text('success_reset_email_sent'.tr()),
                      ),
                    )
                  : Form(
                      key: _formKey,
                      child: StandardInput(
                        color: colorBgLight,
                        initialValue: widget.email,
                        hintText: "hint_email".tr(),
                        isRequiredInput: true,
                        emailFormat: true,
                        onChanged: (value) => _emailAddress = value,
                      ),
                    ),
              SizedBox(
                height: marginStandard,
              ),
              StandardButton(
                width: double.infinity,
                text: _resetEmailSent ? "btn_ok" : "btn_reset",
                onButtonPressed: _resetEmailSent
                    ? () => Navigator.of(context).pop()
                    : () async {
                        if (_formKey.currentState.validate()) {
                          await _authService
                              .resetPassword(_emailAddress)
                              .then((value) => {
                                    setState(() {
                                      _resetEmailSent = true;
                                    })
                                  })
                              .catchError((error) {
                            print(error);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(error.toString()),
                              ),
                            );
                            // return;
                          });
                        }
                      },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
