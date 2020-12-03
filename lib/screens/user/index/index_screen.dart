import 'package:flutter/material.dart';
import 'package:flutter_auth/model/user.dart';
import 'package:flutter_auth/screens/user/index/components/user_index_page.dart';

class UserIndexScreen extends StatelessWidget {
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserIndexPage(user: user),
    );
  }

  UserIndexScreen({this.user});
}
