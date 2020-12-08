import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants/constants.dart';
import 'package:flutter_auth/utils/web_util.dart';

class IconTextPage extends StatelessWidget {
  final Size size;
  final IconData icon;
  final String link;
  final double fontSize;

  const IconTextPage({
    Key key,
    this.size,
    this.icon,
    this.link,
    this.fontSize = kPrimarySmallFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (size == null) {
      return SizedBox();
    }
    return SizedBox(
      width: size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.01),
          SizedBox(
            height: size.height * 0.02,
            child: Row(
              children: [
                SizedBox(
                    child: Icon(
                  icon,
                  color: kPrimaryColor,
                  size: fontSize,
                )),
                SizedBox(
                  width: size.width * 0.01,
                ),
                SizedBox(
                  child: GestureDetector(
                    onTap: () {
                      if (!'link'.contains('http')) {
                        print('$link is not a link');
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return WebViewPage(
                              url: link,
                              title: link,
                            );
                          },
                        ),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        text: link,
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: fontSize,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
