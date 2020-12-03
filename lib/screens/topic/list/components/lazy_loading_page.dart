import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/components/toast/toast.dart';
import 'package:flutter_auth/model/topic.dart';

import '../../../../constants/constants.dart';
import 'list_item.dart';

class LazyLoadingPage extends StatefulWidget {
  final String title;

  LazyLoadingPage({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _LazyLoadingPageState(
        title,
      );
}

class _LazyLoadingPageState extends State<LazyLoadingPage> {
  String _title;
  List<Topic> _myList = new List<Topic>();
  ScrollController _scrollController = ScrollController();
  int _offset = 0;
  int _limit = 10;
  bool _hasMore = true;

  _LazyLoadingPageState(String title) {
    print('title=$title' + '_offset=$_offset');
    this._title = title;
    if (_offset == 0) {
      _getMoreData();
    }
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_hasMore) {
          print('下拉了，有下一页');
          // fixme 如果有新的话题，会出现重复
          _getMoreData();
        } else {
          print('下拉了，但是没有下一页');
          commonToast('没有更老的话题了');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          commonToast('新增话题，暂未开发');
        },
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(),
        child: _buildList(),
      ),
    );
  }

  _getMoreData() {
    _getCurrentPage(false);
    _offset = _offset + _limit;
  }

  _onRefresh() async {
    _offset = 0;
    _getCurrentPage(true);
    _offset = _offset + _limit;
  }

  _getCurrentPage(bool refresh) async {
    Response response = await dio.get(
      apiHost + apiPath.topic.basePath + jsonPath,
      queryParameters: {"offset": _offset, "limit": _limit},
    );
    if (response == null || response.statusCode != httpStatusOk) {
      return;
    }
    TopicListData topicsData = TopicListData.fromJson(response.data);
    if (refresh) {
      _myList.clear();
    }
    topicsData.topics.forEach((t) {
      _myList.add(t);
    });
    if (topicsData.topics.length < _limit) {
      _hasMore = false;
    }
    this.setState(() {});
  }

  _buildList() {
    return ListView.builder(
      controller: _scrollController,
      itemExtent: 80,
      itemBuilder: (context, i) {
        if (i == _myList.length) {
          return CupertinoActivityIndicator();
        }
        Topic topics = _myList[i];
        return ListItemCard(
          topic: topics,
        );
      },
      itemCount: _myList.length + 1,
    );
  }
}
