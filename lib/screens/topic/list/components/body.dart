import 'package:flutter/material.dart';
import './lazy_loading_page.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LazyLoadingPage(
      title: '话题列表',
    );
  }
}
