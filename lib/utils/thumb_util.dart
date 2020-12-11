import 'package:flutter/material.dart';
import 'package:flutter_auth/constants/constants.dart';

class ThumbPage extends StatelessWidget {
  final int count;
  final IconData icon;

  const ThumbPage({
    Key key,
    this.count,
    this.icon = Icons.thumb_up_rounded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (count == null || count == 0) {
      return Row();
    }
    return Row(
      children: [
        Text(count.toString() + ' ',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: kPrimarySmallFontSize,
            )),
        Icon(
          icon,
          color: kPrimaryColor,
          size: kPrimarySmallFontSize,
        ),
      ],
    );
  }
}
