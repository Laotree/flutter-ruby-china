import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/components/toast/toast.dart';
import 'package:flutter_auth/model/topic.dart';
import 'package:flutter_auth/model/user.dart';
import 'package:flutter_auth/screens/topic/detail/components/reply_list_page.dart';
import 'package:flutter_auth/screens/user/index/index_screen.dart';
import 'package:flutter_auth/utils/html_util.dart';
import 'package:flutter_auth/utils/thumb_util.dart';

import '../../../../constants/constants.dart';

class TopicDetailPage extends StatefulWidget {
  final Topic topic;

  TopicDetailPage({
    Key key,
    this.topic,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _TopicDetailPageState(
        topic,
      );
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  Topic _topic;
  Size _size;

  ScrollController _topicController = new ScrollController();

  _TopicDetailPageState(Topic topics) {
    this._topic = topics;
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _topic.title,
          maxLines: 1,
        ),
      ),
      body: SingleChildScrollView(
        controller: _topicController,
        child: Column(
          children: [
            _head(),
            _body(),
            ReplyLoadingPage(
              topic: _topic,
              scrollController: _topicController,
            ),
          ],
        ),
      ),
    );
  }

  _head() {
    int titleRow = (_topic.title.length / 35).round() + 1;
    return Row(children: [
      SizedBox(
        width: _size.width * 0.05,
      ),
      SizedBox(
        width: _size.width * 0.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _size.height * 0.01),
            SizedBox(
              height: _size.height * 0.07,
              child: GestureDetector(
                onTap: () {
                  _gotoUserIndexPage(context, _topic.user);
                },
                child: Container(
                    width: _size.height * 0.08,
                    height: _size.height * 0.08,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(_topic.user.avatarUrl),
                          fit: BoxFit.cover,
                        ))),
              ),
            ),
            SizedBox(height: _size.height * 0.01),
          ],
        ),
      ),
      SizedBox(
        width: _size.width * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _size.height * 0.02),
            SizedBox(
              height: titleRow * _size.height * 0.026,
              child: Text(
                _topic.title,
                maxLines: titleRow,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: kPrimaryFontSize,
                ),
              ),
            ),
            SizedBox(height: _size.height * 0.01),
            SizedBox(
              height: _size.height * 0.03,
              child: Row(
                children: [
                  SizedBox(
                    width: _size.width * 0.35,
                    child: Text(
                      _topic.createdAt,
                      maxLines: 1,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: kPrimarySmallFontSize,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: _size.width * 0.04,
                    child: _topic.grade == 'excellent'
                        ? SizedBox(
                            child: GestureDetector(
                              onTap: () {
                                commonToast('精华帖');
                              },
                              child: Icon(
                                Icons.bookmark_rounded,
                                color: kPrimaryColor,
                                size: kPrimaryFontSize,
                              ),
                            ),
                          )
                        : SizedBox(),
                  ),
                  SizedBox(
                    width: _size.width * 0.01,
                  ),
                  SizedBox(
                    width: _size.width * 0.15,
                    child: ThumbPage(
                      count: _topic.hits,
                      icon: Icons.remove_red_eye_rounded,
                    ),
                  ),
                  SizedBox(
                    width: _size.width * 0.1,
                    child: ThumbPage(count: _topic.likesCount),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        width: _size.width * 0.05,
      ),
    ]);
  }

  _body() {
    return Column(
      children: [
        SizedBox(
          width: _size.width * 0.05,
        ),
        SizedBox(
          width: _size.width * 0.9,
          child: TextFieldContainer(
              child: HtmlViewPage(
            html: _topic.bodyHtml,
          )),
        ),
        SizedBox(
          width: _size.width * 0.05,
        )
      ],
    );
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
}
