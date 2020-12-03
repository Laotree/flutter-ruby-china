import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants/constants.dart';
import 'package:flutter_auth/model/reply.dart';
import 'package:flutter_auth/model/topic.dart';
import 'package:flutter_auth/screens/topic/detail/detail_screen.dart';

import 'html_util.dart';

class ActionPage extends StatelessWidget {
  final Reply reply;

  const ActionPage({
    Key key,
    this.reply,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (reply == null || reply.action == 'null') {
      return Column();
    }
    if (actionMap[reply.action] == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: HtmlViewPage(
              html: reply.bodyHtml,
            ),
          ),
        ],
      );
    }
    if (reply.action == 'mention') {
      return GestureDetector(
        onTap: () {
          _gotoTopicsDetailPage(context, reply.mentionTopic);
        },
        child: Text(reply.mentionTopic.lastReplyUserLogin+ '在' + reply.mentionTopic.title + actionMap[reply.action],
          style: TextStyle(color: kPrimaryColor),),
      );
    } else {
      return Text(
        actionMap[reply.action],
        style: TextStyle(color: kPrimaryColor),
      );
    }
  }

  void _gotoTopicsDetailPage(BuildContext context, Topic topic) async {
    String url =  apiHost + apiPath.topic.basePath + '/' + topic.id.toString() + jsonPath;
    Response response = await dio.get(url);
    if (response == null || response.statusCode != httpStatusOk) {
      return;
    }
    TopicDetailData topicsData = TopicDetailData.fromJson(response.data);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return TopicDetailScreen(
            topics: topicsData.topic,
          );
        },
      ),
    );
  }
}
