import 'package:flutter_auth/components/toast/toast.dart';

class Login {
  String username;
  String password;

  bool checkParams() {
    if (username == null || username.length == 0) {
      commonToast('请输入账号');
      return false;
    }
    if (password == null || password.length == 0) {
      commonToast('请输入密码');
      return false;
    }

    return true;
  }
}

class LoginResponse {
  String accessToken;
  String tokenType;
  int expiresIn;
  String refreshToken;
  String scope;
  int createdAt;

  LoginResponse(
      {this.accessToken,
        this.tokenType,
        this.expiresIn,
        this.refreshToken,
        this.scope,
        this.createdAt});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    refreshToken = json['refresh_token'];
    scope = json['scope'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['refresh_token'] = this.refreshToken;
    data['scope'] = this.scope;
    data['created_at'] = this.createdAt;
    return data;
  }
}
