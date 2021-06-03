import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:organik/utils/dialog_util.dart';
import 'package:provider/provider.dart';

import 'package:organik/services/auth_service.dart';
import 'package:organik/widgets/app_header.dart';
import 'package:organik/widgets/button_standard.dart';
import 'package:organik/widgets/lang_picker.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../constants.dart';
import 'account_type_picker.dart';

class LoginScreen extends StatefulWidget {
  static const ROUTE_NAME = "AccountTypePicker";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  AuthService _authService;

  @override
  void didChangeDependencies() {
    _authService = context.watch<AuthService>();
    super.didChangeDependencies();
  }

  var _email = "";
  var _password = "";

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBgDark,
        elevation: 0,
      ),
      backgroundColor: colorBgDark,
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: marginStandard, horizontal: marginLarge),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppHeader(
                bigHeader: true,
              ),
              Container(
                margin: EdgeInsets.only(top: 100.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        ///Email Input
                        margin: EdgeInsets.only(bottom: marginLarge),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(radiusStandard),
                          ),
                          color: colorPrimaryLight,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: marginStandard,
                              vertical: marginSmall),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "hint_email".tr(),
                            ),
                            onChanged: (val) => _email = val.trim(),
                            cursorColor: colorAccent,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "error_empty_field".tr();
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Container(
                        ///Password Input
                        margin: EdgeInsets.only(bottom: marginStandard),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(radiusStandard),
                          ),
                          color: colorPrimaryLight,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: marginStandard,
                              vertical: marginSmall),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "hint_password".tr(),
                            ),
                            obscureText: true,
                            onChanged: (val) => _password = val.trim(),
                            cursorColor: colorAccent,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "error_empty_field".tr();
                              }
                              if (value.length < 6) {
                                return "error_short_password".tr();
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                ///Forgot Password Container
                width: double.infinity,
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(bottom: marginLarge),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () =>
                          DialogUtil.showResetPasswordDialog(context, _email),
                    text: 'label_forgot_password'.tr(),
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: fontSizeSmall,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: marginStandard),
                child: StandardButton(
                  width: _size.width,
                  text: "btn_login".tr(),
                  isLoading: _authService.isLoading,
                  onButtonPressed: () {
                    if (_formKey.currentState.validate()) {
                      print("Email is $_email");
                      print("Password is $_password");
                      _authService
                          .signInWithEmailAndPassword(_email, _password)
                          .catchError((error) {
                        print(error.toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(error),
                          ),
                        );
                      });
                    }
                  },
                ),
              ),
              Container(
                ///Create account Container
                width: double.infinity,
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: marginLarge),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                          text: "label_do_not_have_account".tr(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: fontSizeSmall,
                          )),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('clicked');
                              Navigator.of(context)
                                  .pushNamed(AccountTypePicker.ROUTE_NAME);
                            },
                          text: 'label_create_account'.tr(),
                          style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              fontSize: fontSizeSmall)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              LangPicker(),
              SizedBox(
                height: marginLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
