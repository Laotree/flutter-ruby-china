

import 'package:flutter/material.dart';
import 'package:flutter_auth/constants/constants.dart';

BuildContext currentContext;
showLoadingDialog(BuildContext context) {
  currentContext = context;
  if (currentContext == null) {
    return;
  }
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (currentContext) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.only(top: 26.0),
              child: Text("正在加载，请稍后...", style: TextStyle(color: kPrimaryColor),),
            )
          ],
        ),
      );
    },
  );
}

hideLoadingDialog() {
  if (currentContext == null) {
    return;
  }
  Navigator.of(currentContext).pop(1);
}