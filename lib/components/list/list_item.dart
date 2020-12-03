import 'package:flutter/material.dart';
import 'package:flutter_auth/constants/constants.dart';

class ListItem {
  final int id;
  final String title, description;

  ListItem({
    @required this.id,
    @required this.title,
    @required this.description,
  });
}

class ListItemCard extends StatelessWidget {
  const ListItemCard({
    Key key,
    @required this.item,
  }) : super(key: key);

  final ListItem item;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(children: [
      SizedBox(width: size.width * 0.1),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.01),
          Text(
            item.title,
            style: TextStyle(
                color: kPrimaryColor, fontSize: kPrimaryMiddleFontSize),
          ),
          SizedBox(height: size.height * 0.01),
          Text.rich(
            TextSpan(
              text: item.description,
              style: TextStyle(color: kPrimaryColor),
            ),
          ),
        ],
      ),
      SizedBox(
        width: size.width * 0.2,
      ),
      SizedBox(
        width: size.width * 0.3,
        child: TextField(
          readOnly: true,
          onTap: () {
            print('------item.id =' + item.id.toString());
          },
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            hintText: 'item.id=' + item.id.toString(),
            suffixIcon: new GestureDetector(
                onTap: () {
                  print('item.id =' + item.id.toString());
                },
                child: Icon(
                  Icons.arrow_forward,
                  color: kPrimaryColor,
                )),
            border: InputBorder.none,
          ),
        ),
      ),
    ]);
  }
}
