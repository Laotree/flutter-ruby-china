import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/components/storage/kv_storage.dart';
import 'package:flutter_auth/constants/constants.dart';
import 'package:flutter_auth/screens/topic/list/list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isAuthValid= storage.init();
    initDio();
    initActionMap();
    initHtmlStyleMap();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ruby-China',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: isAuthValid?TopicListScreen():WelcomeScreen(),
    );
  }

}
