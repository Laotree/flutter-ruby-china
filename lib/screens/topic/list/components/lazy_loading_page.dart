import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/components/toast/toast.dart';
import 'package:flutter_auth/model/node.dart';
import 'package:flutter_auth/model/topic.dart';
import 'package:flutter_tag_layout/flutter_tag_layout.dart';
import '../../../../constants/constants.dart';
import 'list_item.dart';

class LazyLoadingPage extends StatefulWidget {
  LazyLoadingPage({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _LazyLoadingPageState();
}

class _LazyLoadingPageState extends State<LazyLoadingPage> {
  String _title;
  List<Topic> _myList = new List<Topic>();
  ScrollController _scrollController = ScrollController();
  int _offset = 0;
  int _limit = 10;
  bool _hasMore = true;
  String _selectedType = 'last_actived';
  String _selectedTypeDesc = '最近活跃';
  List<String> _typeList = [
    'last_actived',
    'recent',
    'no_reply',
    'last_reply',
    'excellent'
  ];
  List<String> _typeDescList = ['最近活跃', '最新发布', '无人问津', '最新回复', '精华帖'];
  int _selectedTypeIndex = 0;

  ///文本标签集合
  List<String> _nodeDescList = [];
  List<int> _nodeIDList = [];
  int _selectedNodeIndex;
  int _selectedNodeID;

  List<Widget> _drawerChildren = new List<Widget>();

  _LazyLoadingPageState() {
    this._title = _selectedTypeDesc;
    _getNodeList();
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
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: _drawerChildren,
        ),
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
      queryParameters: {
        "offset": _offset,
        "limit": _limit,
        "type": _selectedType,
        "node_id": _selectedNodeID,
      },
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
    _buildDrawerChildren();
    this.setState(() {});
  }

  _getNodeList() async {
    Response response = await dio.get(
      apiHost + apiPath.node.basePath + jsonPath,
    );
    if (response == null || response.statusCode != httpStatusOk) {
      return;
    }
    NodeListData nodeListData = NodeListData.fromJson(response.data);

    nodeListData.nodes.forEach((n) {
      if (n.topicsCount < 200) {
        return;
      }
      _nodeDescList.add(n.name);
      _nodeIDList.add(n.id);
    });
    this.setState(() {});
  }

  _buildList() {
    return ListView.builder(
      controller: _scrollController,
      shrinkWrap: true,
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

  _buildDrawerChildren() {
    _drawerChildren.clear();
    _drawerChildren.add(DrawerHeader(
      child: Text(
        '话题筛选',
        style:
            TextStyle(color: kPrimaryColor, fontSize: kPrimaryMiddleFontSize),
      ),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
      ),
    ));

    for (var i = 0; i < _typeDescList.length; i++) {
      var str = _typeDescList[i];
      if (i == _selectedTypeIndex) {
        _drawerChildren.add(ListTile(
          title: Row(
            children: [
              Icon(
                Icons.radio_button_checked_rounded,
                color: kPrimaryColor,
              ),
              Text(
                str,
                style:
                    TextStyle(color: kPrimaryColor, fontSize: kPrimaryFontSize),
              ),
            ],
          ),
          onTap: () {
            _selectedTypeDesc = _typeDescList[0];
            _selectedType = _typeList[0];
            this._title = _selectedTypeDesc;
            Navigator.pop(context);
            _onRefresh();
          },
        ));
      } else {
        _drawerChildren.add(ListTile(
          title: Row(
            children: [
              Icon(
                Icons.radio_button_off_rounded,
                color: kPrimaryLightColor,
              ),
              Text(
                str,
                style:
                    TextStyle(color: kPrimaryColor, fontSize: kPrimaryFontSize),
              ),
            ],
          ),
          onTap: () {
            _selectedTypeDesc = str;
            _selectedType = _typeList[i];
            this._title = _selectedTypeDesc;
            _selectedTypeIndex = i;
            Navigator.pop(context);
            _onRefresh();
          },
        ));
      }
    }
    List<Widget> itemWidgetList = [];
    for (var i = 0; i < _nodeDescList.length; i++) {
      var str = _nodeDescList[i];
      if (i == _selectedNodeIndex) {
        itemWidgetList.add(GestureDetector(
          onTap: () {
            _selectedNodeIndex = null;
            _selectedNodeID = null;
            Navigator.pop(context);
            _onRefresh();
          },
          child: TextTagWidget("$str",
              textStyle: TextStyle(color: kPrimaryLightColor),
              backgroundColor: kPrimaryColor),
        ));
      } else {
        itemWidgetList.add(GestureDetector(
          onTap: () {
            _selectedNodeIndex = i;
            _selectedNodeID = _nodeIDList[i];
            Navigator.pop(context);
            _onRefresh();
          },
          child: TextTagWidget("$str",
              textStyle: TextStyle(color: kPrimaryColor),
              backgroundColor: kPrimaryLightColor),
        ));
      }
    }
    _drawerChildren.add(Container(
      margin: EdgeInsets.only(top: 10.0, left: 5, right: 5),

      ///流式布局
      child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,

          ///子标签
          children: itemWidgetList),
    ));
  }
}
