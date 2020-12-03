import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/constants/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  RoundedPasswordField({
    Key key,
    this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      new _RoundedPasswordField(hintText, onChanged);
}

class _RoundedPasswordField extends State<RoundedPasswordField> {
  bool _obscureText = true;
  String _hintText;
  ValueChanged<String> onChanged;

  _RoundedPasswordField(String hintText, ValueChanged<String> onChanged) {
    this._hintText = hintText;
    this.onChanged = onChanged;
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: _obscureText,
        cursorColor: kPrimaryColor,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: _hintText,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: new GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: new Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
