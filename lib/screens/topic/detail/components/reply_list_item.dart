import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/components/toast/toast.dart';
import 'package:flutter_auth/model/reply.dart';
import 'package:flutter_auth/model/topic.dart';
import 'package:flutter_auth/model/user.dart';
import 'package:flutter_auth/screens/topic/detail/detail_screen.dart';
import 'package:flutter_auth/screens/user/index/index_screen.dart';
import 'package:flutter_auth/utils/action_util.dart';
import 'package:flutter_auth/utils/html_util.dart';
import 'package:flutter_auth/utils/thumb_util.dart';
import 'package:flutter_auth/utils/web_util.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../constants/constants.dart';

class ReplyItemCard extends StatelessWidget {
  final Reply reply;

  const ReplyItemCard({
    Key key,
    @required this.reply,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(children: [
      SizedBox(
        width: size.width * 0.05,
      ),
      SizedBox(
        width: size.width * 0.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.01),
            SizedBox(
                height: size.height * 0.07,
                child: GestureDetector(
                  onTap: () {
                    _gotoUserIndexPage(context, reply.user);
                  },
                  child: Container(
                      width: size.height * 0.08,
                      height: size.height * 0.08,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(reply.user.avatarUrl),
                            fit: BoxFit.cover,
                          ))),
                )),
            SizedBox(height: size.height * 0.01),
            SizedBox(
              height: size.height * 0.025,
              child: Text(
                reply.user.name == null ? reply.user.login : reply.user.name,
                maxLines: 1,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: kPrimaryFontSize,
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        width: size.width * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldContainer(
              child: GestureDetector(
                onTap: () {
                  // _gotoTopicsDetailPage(context, reply);
                  // commonToast('您点击了');
                },
                child: ActionPage(reply: reply),
              ),
            ),
            SizedBox(
              height: size.height * 0.025,
              child: Row(
                children: [
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  SizedBox(
                    child: Text(
                      reply.createdAt,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: kPrimarySmallFontSize,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.2,
                  ),
                  SizedBox(
                    width: size.width * 0.1,
                    child: ThumbPage(count: reply.likesCount),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        width: size.width * 0.05,
      ),
    ]);
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
