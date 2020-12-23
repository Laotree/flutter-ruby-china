import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_auth/components/storage/kv_storage.dart';
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

// author 2.0
const clientID = 'a4246458';

const twitterLink = 'https://twitter.com/';
const githubLink = 'https://github.com/';
const jsonPath = '.json';

class RequestPath {
  AuthPath auth;
  TopicPath topic;
  UserPath user;
  NodePath node;

  RequestPath(
    this.auth,
    this.topic,
    this.user,
    this.node,
  );
}

class AuthPath {
  String token;

  AuthPath(
    this.token,
  );
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
  AuthPath(
    '/oauth/token'
  ),
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
  String refreshToken;
  String accessToken;
  String rememberMe;

  StorageKey(
    this.refreshToken,
    this.accessToken,
    this.rememberMe,
  );
}

var storageKey = StorageKey(
  'REFRESH_TOKEN',
  'ACCESS_TOKEN',
  'REMEMBER_ME',
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
        // TODO 如果accessToken 存在，则把accessToken放在query
        String accessToken = storage.getString(storageKey.accessToken);
        if (accessToken != null && accessToken.isNotEmpty) {
          print('登录状态$accessToken');
          options.queryParameters.addAll({"access_token": accessToken});
        }
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
