import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/model/user.dart';
import 'package:flutter_auth/utils/html_util.dart';
import 'package:flutter_auth/utils/web_util.dart';

import '../../../../constants/constants.dart';
import 'icon_text.dart';

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
  User _userDetail;
  Size _size;

  _UserIndexPageState(User user) {
    this._user = user;
    _getUserDetail();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    String title = (_user.name == null ? _user.login : _user.name) + '主页';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            _head(),
            _body(),
          ],
        ),
      ),
    );
  }

  _head() {
    return Row(children: [
      SizedBox(
        width: _size.width * 0.05,
      ),
      SizedBox(
        width: _size.width * 0.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _size.height * 0.01),
            SizedBox(
                height: _size.height * 0.07,
                child: GestureDetector(
                  onTap: () {
                    print('tap??tap');
                  },
                  child: Container(
                      width: _size.height * 0.08,
                      height: _size.height * 0.08,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(_user.avatarUrl),
                            fit: BoxFit.cover,
                          ))),
                )),
            SizedBox(height: _size.height * 0.01),
          ],
        ),
      ),
      SizedBox(
        width: _size.width * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _size.height * 0.01),
            SizedBox(
              height: _size.height * 0.03,
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
              height: _size.height * 0.02,
              child: Row(
                children: [
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
            SizedBox(
              height: _size.height * 0.02,
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
                    width: _size.width * 0.05,
                  ),
                ],
              ),
            ),
            SizedBox(height: _size.height * 0.01),
          ],
        ),
      ),
      SizedBox(
        width: _size.width * 0.05,
      ),
    ]);
  }

  _body() {
    List<Widget> children = [];
    if (_userDetail != null) {
      if (_userDetail.location != null && _userDetail.location.length > 0) {
        children.add(IconTextPage(
          size: _size,
          icon: Icons.location_city_rounded,
          link: _userDetail.location,
        ));
      }
      if (_userDetail.company != null && _userDetail.company.length > 0) {
        children.add(IconTextPage(
          size: _size,
          icon: Icons.backpack_rounded,
          link: _userDetail.company,
        ));
      }
      if (_userDetail.twitter != null && _userDetail.twitter.length > 0) {
        children.add(IconTextPage(
          size: _size,
          icon: Icons.chat_rounded,
          link: twitterLink + _userDetail.twitter,
        ));
      }
      if (_userDetail.github != null && _userDetail.github.length > 0) {
        children.add(IconTextPage(
          size: _size,
          icon: Icons.code,
          link: githubLink + _userDetail.github,
        ));
      }
      if (_userDetail.website != null && _userDetail.website.length > 0) {
        children.add(IconTextPage(
          size: _size,
          icon: Icons.web,
          link: _userDetail.website,
        ));
      }

      if (_userDetail.bio != null && _userDetail.bio.length > 0) {
        children.add(SizedBox(
          child: Column(
            children: [
              SizedBox(
                width: _size.width * 0.05,
              ),
              SizedBox(
                  width: _size.width * 0.9,
                  child: Column(
                    children: [
                      TextFieldContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HtmlViewPage(
                              html: _userDetail.bio,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                width: _size.width * 0.05,
              )
            ],
          ),
        ));
      }
      // "topics_count":51,"replies_count":409,"following_count":4,"followers_count":41,"favorites_count":8,
      if (_userDetail.topicsCount > 0 && _userDetail.repliesCount > 0) {
        children.add(SizedBox(
          width: _size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: _size.height * 0.01),
              SizedBox(
                height: _size.height * 0.05,
                child: Row(
                  children: [
                    SizedBox(
                      child: Text.rich(
                        TextSpan(
                          text: '话题: ' + _userDetail.topicsCount.toString(),
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: kPrimaryFontSize,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: _size.height * 0.01),
            ],
          ),
        ));
        children.add(SizedBox(
          width: _size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: _size.height * 0.01),
              SizedBox(
                height: _size.height * 0.05,
                child: Row(
                  children: [
                    SizedBox(
                      child: Text.rich(
                        TextSpan(
                          text: '回帖: ' + _userDetail.repliesCount.toString(),
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: kPrimaryFontSize,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: _size.height * 0.01),
            ],
          ),
        ));
        children.add(SizedBox(
          width: _size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: _size.height * 0.01),
              SizedBox(
                height: _size.height * 0.05,
                child: Row(
                  children: [
                    SizedBox(
                      child: Text.rich(
                        TextSpan(
                          text: '收藏: ' + _userDetail.favoritesCount.toString(),
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: kPrimaryFontSize,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: _size.height * 0.01),
            ],
          ),
        ));
        children.add(SizedBox(
          width: _size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: _size.height * 0.01),
              SizedBox(
                height: _size.height * 0.05,
                child: Row(
                  children: [
                    SizedBox(
                      child: Text.rich(
                        TextSpan(
                          text:
                              '正在关注: ' + _userDetail.followingCount.toString(),
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: kPrimaryFontSize,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: _size.height * 0.01),
            ],
          ),
        ));
        children.add(SizedBox(
          width: _size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: _size.height * 0.01),
              SizedBox(
                height: _size.height * 0.05,
                child: Row(
                  children: [
                    SizedBox(
                      child: Text.rich(
                        TextSpan(
                          text: '关注者: ' + _userDetail.followersCount.toString(),
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: kPrimaryFontSize,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: _size.height * 0.01),
            ],
          ),
        ));
      }
    }

    return Column(
      children: children,
    );
  }

  _getUserDetail() async {
    Response response = await dio.get(
      apiHost + apiPath.user.basePath + '/' + _user.login + jsonPath,
    );
    if (response == null || response.statusCode != httpStatusOk) {
      return;
    }
    UserData userData = UserData.fromJson(response.data);
    _userDetail = userData.user;
    this.setState(() {});
  }
}
