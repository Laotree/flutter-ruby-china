import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/components/toast/toast.dart';
import 'package:flutter_auth/model/reply.dart';
import 'package:flutter_auth/model/topic.dart';
import 'package:flutter_auth/screens/topic/detail/components/reply_list_item.dart';

import '../../../../constants/constants.dart';

class ReplyLoadingPage extends StatefulWidget {
  final Topic topic;
  final ScrollController scrollController;

  ReplyLoadingPage({Key key, this.topic, this.scrollController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      new _ReplyLoadingPageState(topic, scrollController);
}

class _ReplyLoadingPageState extends State<ReplyLoadingPage> {
  Topic _topic;
  List<Reply> _myList = new List<Reply>();
  ScrollController _scrollController;
  int _offset = 0;
  int _limit = 10;
  bool _hasMore = true;

  _ReplyLoadingPageState(Topic topic, ScrollController scrollController) {
    this._topic = topic;
    this._scrollController = scrollController;
    if (_offset == 0) {
      _getMoreData();
    }
    // fixme list block
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_myList.length == 0) {
          commonToast('暂无回复');
          return;
        }
        if (_hasMore) {
          print('下拉了，有下一页');
          // fixme 如果有新的话题，会出现重复
          _getMoreData();
        } else {
          print('下拉了，但是没有下一页');
          commonToast('没有更新的回复了');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }

  _getMoreData() {
    _getCurrentPage();
  }

  _getCurrentPage() async {
    Response response = await dio.get(
      apiHost +
          apiPath.topic.basePath +
          '/' +
          _topic.id.toString() +
          '/replies' +
          jsonPath,
      queryParameters: {"offset": _offset, "limit": _limit},
    );
    if (response == null || response.statusCode != httpStatusOk) {
      return;
    }
    RepliesData repliesData = RepliesData.fromJson(response.data);

    repliesData.replies.forEach((t) {
      _myList.add(t);
    });
    if (repliesData.replies.length < _limit) {
      _hasMore = false;
    } else {
      _hasMore = true;
    }
    _offset = _offset + _limit;

    this.setState(() {});
  }

  _buildList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: new NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        if (i == _myList.length) {
          return CupertinoActivityIndicator();
        }
        Reply reply = _myList[i];
        return ReplyItemCard(
          reply: reply,
        );
      },
      itemCount: _myList.length,
    );
  }
}
