import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/components/background.dart';
import 'package:flutter_auth/components/button/rounded_button.dart';
import 'package:flutter_auth/components/input/rounded_input_field.dart';
import 'package:flutter_auth/components/input/rounded_password_field.dart';
import 'package:flutter_auth/components/input/rounded_switch_field.dart';
import 'package:flutter_auth/components/storage/kv_storage.dart';
import 'package:flutter_auth/constants/constants.dart';
import 'package:flutter_auth/model/login.dart';
import 'package:flutter_auth/screens/topic/list/list_screen.dart';

class Body extends StatefulWidget {
  Body({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _Body();
}

class _Body extends State<Body> {
  Size _size;
  Login _login = Login();

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '登录',
        ),
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: _size.height * 0.03),
              RoundedInputField(
                hintText: '账号',
                onChanged: (value) {
                  _login.username = value;
                },
              ),
              RoundedPasswordField(
                hintText: '密码',
                onChanged: (value) {
                  print('value==' + value);
                  _login.password = value;
                },
              ),
              RoundedSwitchField(
                title: '记住我',
                value: storage.getBool(storageKey.rememberMe),
                localKey: storageKey.rememberMe,
              ),
              RoundedButton(
                text: "登录",
                press: () {
                  if (_login.checkParams()) {
                    login(context);
                  }
                },
              ),
              SizedBox(height: _size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  login(BuildContext context) async {
    print('login in username=${_login.username} password=${_login.password}');
    var data = FormData.fromMap({
      "client_id": clientID,
      "grant_type": "password",
      "username": _login.username,
      "password": _login.password,
    });
    Response response = await dio.post(
      apiHost + apiPath.auth.token,
      data: data,
    );
    if (response == null || response.statusCode != httpStatusOk) {
      return;
    }
    LoginResponse loginResponse = LoginResponse.fromJson(response.data);
    if (loginResponse.accessToken!= null && loginResponse.accessToken.length>0) {
      storage.setString(storageKey.accessToken, loginResponse.accessToken);
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return TopicListScreen();
        },
      ),
    );
  }
}
