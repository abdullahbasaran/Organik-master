import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:organik/screens/authentication/login_screen.dart';
import 'package:organik/services/auth_service.dart';
import 'package:organik/widgets/app_header.dart';
import 'package:organik/widgets/button_standard.dart';
import 'package:organik/widgets/input_standard.dart';
import 'package:organik/widgets/lang_picker.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../constants.dart';

class RegisterAccountScreen extends StatefulWidget {
  static const ROUTE_NAME = "RegisterCustomerScreen";

  @override
  _RegisterAccountScreenState createState() => _RegisterAccountScreenState();
}

class _RegisterAccountScreenState extends State<RegisterAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  AuthService _authService;

  @override
  void didChangeDependencies() {
    _authService = context.watch<AuthService>();
    super.didChangeDependencies();
  }

  var _name = "";
  var _email = "";
  var _password = "";
  var _rPassword = "";

  @override
  Widget build(BuildContext context) {
    final _userType = ModalRoute.of(context).settings.arguments;
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBgDark,
        elevation: 0,
      ),
      backgroundColor: colorBgDark,
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: marginStandard, horizontal: marginLarge),
        child: Column(
          children: [
            AppHeader(
              bigHeader: true,
            ),
            SizedBox(
              height: 100,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          StandardInput(
                            ///Name Input
                            hintText: _userType == UserType.CUSTOMER
                                ? "hint_name".tr()
                                : "hint_shop_name".tr(),
                            isRequiredInput: true,
                            minLength: 3,
                            onChanged: (val) => _name = val.trim(),
                          ),
                          StandardInput(
                            ///Email Input
                            hintText: "hint_email".tr(),
                            isRequiredInput: true,
                            emailFormat: true,
                            onChanged: (val) => _email = val.trim(),
                          ),
                          StandardInput(
                            ///Password Input
                            isObscureText: true,
                            hintText: "hint_password".tr(),
                            isRequiredInput: true,
                            onChanged: (val) => _password = val.trim(),
                          ),
                          StandardInput(
                            ///Repeat Password Input
                            isObscureText: true,
                            onChanged: (_) {},
                            hintText: "hint_repeat_password".tr(),
                            validator: (val) {
                              if (val.isEmpty) {
                                return "error_empty_field".tr();
                              }
                              if (_password.trim() != val) {
                                return "error_passwords_not_match".tr();
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      ///create account button
                      margin: EdgeInsets.only(bottom: marginStandard),
                      child: StandardButton(
                        width: _size.width,
                        text: _userType == UserType.CUSTOMER
                            ? "btn_create_account".tr()
                            : "btn_create_shop".tr(),
                        isLoading: _authService.isLoading,
                        onButtonPressed: () async {
                          if (_formKey.currentState.validate()) {
                            print("Name is $_name");
                            print("Email is $_email");
                            print("Password is $_password");
                            print("r Password is $_rPassword");

                            final result = await _authService
                                .signUpWithEmailAndPassword(
                                    _name, _email, _password, _userType)
                                .catchError((error) {
                              print(error.toString());
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(error),
                                ),
                              );
                            });
                            //close this screen if the registeration flow has no error
                            if (result != null) Navigator.of(context).pop();
                          }
                        },
                      ),
                    ),
                    Container(
                      ///Login to account Container
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: marginLarge),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: "label_already_have_account".tr(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: fontSizeSmall,
                              ),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushReplacementNamed(
                                      LoginScreen.ROUTE_NAME);
                                },
                              text: 'btn_login'.tr(),
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                                fontSize: fontSizeSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            LangPicker(),
            SizedBox(
              height: marginLarge,
            ),
          ],
        ),
      ),
    );
  }
}
