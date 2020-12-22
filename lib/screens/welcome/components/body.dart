import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/components/background.dart';
import 'package:flutter_auth/components/button/rounded_button.dart';
import 'package:flutter_auth/components/button/secondary_rounded_button.dart';
import 'package:flutter_auth/components/toast/toast.dart';
import 'package:flutter_auth/constants/constants.dart';
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
                String url = 'https://ruby-china.org/oauth/authorize?client_id=a4246458&redirect_uri=https%3A%2F%2Fraypar.cn%2F&response_type=code&scope=all';
                // String url = apiHost+'/oauth/authorize?client_id='+appID+'&redirect_uri='+callBackUri+'&response_type=code&scope=all';
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WebViewPage(
                        url: url,
                        title: url,
                      );
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
