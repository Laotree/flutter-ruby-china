import 'package:flutter/material.dart';
import 'package:flutter_auth/model/topic.dart';

import 'components/detail_page.dart';

class TopicDetailScreen extends StatelessWidget {
  final Topic topics;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopicDetailPage(topic: this.topics),
    );
  }

  TopicDetailScreen({this.topics});
}
