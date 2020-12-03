import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/model/topic.dart';
import 'package:flutter_auth/model/user.dart';

import '../../../../constants/constants.dart';

class UserIndexPage extends StatefulWidget {
  final User user;

  UserIndexPage({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _UserIndexPageState(
        user,
      );
}

class _UserIndexPageState extends State<UserIndexPage> {
  User _user;

  _UserIndexPageState(User user) {
    this._user = user;
  }

  @override
  Widget build(BuildContext context) {
    String title = (_user.name == null ? _user.login : _user.name) + '主页';

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            _head(size),
          ],
        ),
      ),
    );
  }

  _head(Size size) {
    return Row(children: [
      SizedBox(
        width: size.width * 0.05,
      ),
      SizedBox(
        width: size.width * 0.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.01),
            SizedBox(
                height: size.height * 0.07,
                child: GestureDetector(
                  onTap: () {
                    print('onTap onTap');
                  },
                  child: Container(
                      width: size.height * 0.08,
                      height: size.height * 0.08,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(_user.avatarUrl),
                            fit: BoxFit.cover,
                          ))),
                )),
            SizedBox(height: size.height * 0.01),
          ],
        ),
      ),
      SizedBox(
        width: size.width * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.02),
            SizedBox(
              height: size.height * 0.03,
              child: Text(
                _user.login,
                maxLines: 2,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: kPrimaryFontSize,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
              child: Row(
                children: [
                  SizedBox(
                    child: Text.rich(
                      TextSpan(
                        text: '第 ' + _user.id.toString() + ' 位会员',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: kPrimarySmallFontSize,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  SizedBox(
                    child: Text.rich(
                      TextSpan(
                        text: _user.name,
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: kPrimarySmallFontSize,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.01),
          ],
        ),
      ),
      SizedBox(
        width: size.width * 0.05,
      ),
    ]);
  }
}
