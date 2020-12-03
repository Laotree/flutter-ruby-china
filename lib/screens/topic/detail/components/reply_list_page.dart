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

  ReplyLoadingPage({
    Key key,
    this.topic,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _ReplyLoadingPageState(topic);
}

class _ReplyLoadingPageState extends State<ReplyLoadingPage> {
  Topic _topic;
  List<Reply> _myList = new List<Reply>();
  ScrollController _scrollController = ScrollController();
  int _offset = 0;
  int _limit = 10;
  bool _hasMore = true;

  _ReplyLoadingPageState(Topic topic) {
    this._topic = topic;
    if (_offset == 0) {
      _getMoreData();
    }
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_myList.length < _offset) {
          commonToast('没有更老的回复了');
          return;
        }
        if (_hasMore) {
          print('下拉了，有下一页');
          // fixme 如果有新的话题，会出现重复
          _getMoreData();
        } else {
          print('下拉了，但是没有下一页');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _onRefresh(),
      child: _buildList(),
    );
  }

  _getMoreData() {
    _getCurrentPage(false);
    _offset = _offset + _limit;
  }

  _onRefresh() async {
    print('上啦');
    // _offset = 0;
    // _getCurrentPage(true);
    // _offset = _offset + _limit;
  }

  _getCurrentPage(bool refresh) async {
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
    if (refresh) {
      _myList.clear();
    }
    repliesData.replies.forEach((t) {
      _myList.add(t);
    });
    if (repliesData.replies.length < _limit) {
      _hasMore = false;
    }
    this.setState(() {});
  }

  _buildList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      controller: _scrollController,
      // itemExtent: 80,
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
