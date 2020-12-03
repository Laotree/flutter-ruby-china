import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
  List _myList;
  ScrollController _scrollController = ScrollController();
  int _currentMax = 10;

  _LazyLoadingPageState(String title) {
    print('title=$title');
    this._title = title;
    _myList = List.generate(10, (i) => "Item : ${i + 1}");
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  _getMoreData() {
    for (int i = _currentMax; i < _currentMax + 10; i++) {
      _myList.add("Item : ${i + 1}");
    }

    _currentMax = _currentMax + 10;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemExtent: 80,
        itemBuilder: (context, i) {
          if (i == _myList.length) {
            return CupertinoActivityIndicator();
          }
          String title = 'title=' + _myList[i];
          String description = 'description=' + _myList[i];
          ListItem item =
              ListItem(id: i, title: title, description: description);
          return ListItemCard(item: item);
        },
        itemCount: _myList.length + 1,
      ),
    );
  }
}
