import 'package:flutter/material.dart';
import 'package:flutter_auth/constants/constants.dart';
import 'package:flutter_auth/utils/web_util.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlViewPage extends StatelessWidget {
  final String html;

  const HtmlViewPage({
    Key key,
    this.html,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: html,
      style: htmlStyleMap,
      onLinkTap: (url) {
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
      onImageTap: (url) {
        print(url);
      },
      onImageError: (exception, stackTrace) {
        print(exception);
      },
    );
  }
}
