import 'package:flutter/material.dart';
import 'package:flutter_auth/components/storage/kv_storage.dart';

import '../../constants/constants.dart';

class RoundedSwitchField extends StatefulWidget {
  final String title;
  final bool value;
  final String localKey;
  const RoundedSwitchField({
    Key key,
    this.title,
    this.value,
    this.localKey,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _RoundedSwitchField(
        title,
        value,
        localKey,
      );
}

class _RoundedSwitchField extends State<RoundedSwitchField> {
  String _title;
  bool _value;
  String _localKey;

  _RoundedSwitchField(String title, bool value, String localKey) {
    print('value=$value');
    this._title = title;
    this._value = value;
    this._localKey = localKey;
  }
  //回调函数
  void changeValue() {
    setState(() {
      _value = !_value; //修改状态
    });
    storage.setBool(this._localKey, this._value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        child: SwitchListTile(
          title: TextField(
            onTap: () {
              changeValue();
            },
            readOnly: true,
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
              hintText: _title,
              icon: Icon(
                Icons.receipt,
                color: kPrimaryColor,
              ),
              border: InputBorder.none,
            ),
          ),
          value: _value,
          activeColor: kPrimaryColor,
          activeTrackColor: kPrimaryColor,
          inactiveThumbColor: kPrimaryLightColor,
          inactiveTrackColor: kPrimaryLightColor,
          onChanged: (value) {
            changeValue();
          },
        ));
  }
}
