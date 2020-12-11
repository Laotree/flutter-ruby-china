import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/model/topic.dart';
import 'package:flutter_auth/model/user.dart';
import 'package:flutter_auth/screens/topic/detail/detail_screen.dart';
import 'package:flutter_auth/screens/user/index/index_screen.dart';
import 'package:flutter_tag_layout/flutter_tag_layout.dart';

import '../../../../constants/constants.dart';

class ListItemCard extends StatelessWidget {
  final Topic topic;

  const ListItemCard({
    Key key,
    @required this.topic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(children: [
      SizedBox(
        width: size.width * 0.03,
      ),
      SizedBox(
        width: size.width * 0.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.01),
            SizedBox(
                height: size.height * 0.07,
                child: GestureDetector(
                  onTap: () {
                    _gotoUserIndexPage(context, topic.user);
                  },
                  child: Container(
                      width: size.height * 0.08,
                      height: size.height * 0.08,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(topic.user.avatarUrl),
                            fit: BoxFit.cover,
                          ))),
                )),
            SizedBox(height: size.height * 0.01),
          ],
        ),
      ),
      SizedBox(
          width: size.width * 0.74,
          child: GestureDetector(
            onTap: () {
              _gotoTopicsDetailPage(context, topic);
            },
            child: Row(
              children: _buildChildren(size),
            ),
          )),
      SizedBox(
        width: size.width * 0.03,
      ),
    ]);
  }

  _buildChildren(size) {
    int titleRow = (topic.title.length / 35).round() + 1;
    List<SizedBox> children = new List<SizedBox>();
    double excellentWidth = 0;
    if (topic.grade == 'excellent') {
      excellentWidth = 0.04;
    }
    children.add(SizedBox(
      width: size.width * (0.62 - excellentWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.01,
          ),
          SizedBox(
            height: titleRow * size.height * 0.026,
            child: Text(
              topic.title,
              maxLines: titleRow,
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: kPrimaryFontSize,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.005,
          ),
          SizedBox(
            height: size.height * 0.015,
            child: Text.rich(
              TextSpan(
                text: topic.updatedAt,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: kPrimarySmallFontSize,
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
        ],
      ),
    ));
    if (excellentWidth > 0) {
      children.add(SizedBox(
        width: size.width * (excellentWidth - 0.02),
        child: Icon(
          Icons.bookmark_rounded,
          color: kPrimaryColor,
          size: kPrimaryFontSize,
        ),
      ));
      children.add(SizedBox(
        width: size.width * 0.02,
      ));
    }
    children.add(SizedBox(
      width: size.width * 0.12,
      child: TextTagWidget(topic.repliesCount.toString(),
          textStyle: TextStyle(color: kPrimaryColor),
          backgroundColor: kPrimaryLightColor),
    ));
    return children;
  }

  void _gotoUserIndexPage(BuildContext context, User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return UserIndexScreen(
            user: user,
          );
        },
      ),
    );
  }

  void _gotoTopicsDetailPage(BuildContext context, Topic topic) async {
    String url =
        apiHost + apiPath.topic.basePath + '/' + topic.id.toString() + jsonPath;
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
