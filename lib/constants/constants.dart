import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';

import '../components/dialog/dialog.dart';
import '../components/toast/toast.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

const kPrimarySmallFontSize = 12.0;
const kPrimaryFontSize = 16.0;
const kPrimaryMiddleFontSize = 24.0;
const kPrimaryLargeFontSize = 32.0;

const passwordMaxLength = 8;

const success = 0;
const httpStatusOk = 200;

const apiHost = 'https://ruby-china.org';

const twitterLink = 'https://twitter.com/';
const githubLink = 'https://github.com/';
const jsonPath = '.json';

class RequestPath {
  TopicPath topic;
  UserPath user;
  NodePath node;

  RequestPath(this.topic, this.user, this.node);
}

class TopicPath {
  String basePath;

  TopicPath(
    this.basePath,
  );
}

class UserPath {
  String basePath;

  UserPath(
    this.basePath,
  );
}

class NodePath {
  String basePath;

  NodePath(
    this.basePath,
  );
}

var apiPath = RequestPath(
  TopicPath(
    '/api/v3/topics',
  ),
  UserPath(
    '/api/v3/users',
  ),
  NodePath(
    '/api/v3/nodes',
  ),
);

class StorageKey {
  String rememberMobileNumber;
  String mobileNumber;
  String password;
  String token;

  StorageKey(
    this.rememberMobileNumber,
    this.mobileNumber,
    this.password,
    this.token,
  );
}

var storageKey = StorageKey(
  'REMEMBER_MOBILE_NUMBER',
  'MOBILE_NUMBER',
  'PASSWORD',
  'TOKEN',
);

Dio dio;

initDio() {
  dio = new Dio();
  print('执行dio初始化');
  // 增加拦截器
  dio.interceptors.add(
    InterceptorsWrapper(
      // 接口请求前数据处理
      onRequest: (options) {
        print('执行ing');
        showLoadingDialog(options.extra["context"]);
        return options;
      },
      // 接口成功返回时处理
      onResponse: (Response resp) {
        print(resp);
        hideLoadingDialog();
        return resp;
      },
      // 接口报错时处理
      onError: (DioError error) {
        dangerToast('$error');
        hideLoadingDialog();
        return error;
      },
    ),
  );
  print('执行dio interceptors初始化');
}

Map<String, Style> htmlStyleMap;

initHtmlStyleMap() {
  htmlStyleMap = <String, Style>{};
  htmlStyleMap['html'] = Style(
    backgroundColor: kPrimaryLightColor,
  );
  print('initHtmlStyleMap');
  return htmlStyleMap;
}

Map<String, String> actionMap;

initActionMap() {
  actionMap = <String, String>{};
  actionMap['close'] = '关闭了讨论';
  actionMap['mention'] = '提及了此贴';
  actionMap['excellent'] = '将本帖设为了精华贴';
  print('initActionMap');
}
