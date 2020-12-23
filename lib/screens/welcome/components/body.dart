import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/components/background.dart';
import 'package:flutter_auth/components/button/rounded_button.dart';
import 'package:flutter_auth/components/button/secondary_rounded_button.dart';
import 'package:flutter_auth/components/toast/toast.dart';
import 'package:flutter_auth/constants/constants.dart';
import 'package:flutter_auth/screens/auth/auth_screen.dart';
import 'package:flutter_auth/screens/topic/list/list_screen.dart';
import 'package:flutter_auth/utils/web_util.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "欢迎来到 Ruby China",
              style: TextStyle(
                  fontSize: kPrimaryMiddleFontSize,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "登录",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AuthScreen();
                    },
                  ),
                );
              },
            ),
            SecondaryRoundedButton(
              text: "随便看看",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TopicListScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
