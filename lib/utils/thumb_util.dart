import 'package:flutter/material.dart';
import 'package:flutter_auth/constants/constants.dart';

class ThumbPage extends StatelessWidget {
  final int count;

  const ThumbPage({
    Key key,
    this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (count == null || count == 0) {
      return Row();
    }
    return Row(
      children: [
        Text(count.toString() + ' x ',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: kPrimarySmallFontSize,
            )),
        Icon(
          Icons.thumb_up,
          color: kPrimaryColor,
          size: kPrimarySmallFontSize,
        ),
      ],
    );
  }
}
