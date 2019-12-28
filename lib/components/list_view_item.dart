import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import '../routers/application.dart';
import 'dart:core';

/// 自定义组件，首页 card 中显示用
class ListViewItem extends StatelessWidget {
  final int itemId;
  final String itemUrl;
  final String itemTitle;
  final String itemShareUser;
  final String itemNiceDate;

  const ListViewItem({Key key, this.itemId, this.itemUrl, this.itemTitle, this.itemShareUser,this.itemNiceDate})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: ListTile(
        onTap: () {
          // _launchURL(itemUrl, context);
          Application.router.navigateTo(context, '${Routes.webViewPage}?id=${Uri.encodeComponent(itemId.toString())}&title=${Uri.encodeComponent(itemTitle)}&link=${Uri.encodeComponent(itemUrl)}');
        },
        title: Padding(
          child: Text(
            itemTitle,
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          ),
          padding: EdgeInsets.only(top: 10.0),
        ),
        subtitle: Row(
          children: <Widget>[
            Padding(
              child: Text(itemShareUser,
                  style: TextStyle(color: Colors.black54, fontSize: 10.0)),
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            ),
            Padding(
              child: Text(itemNiceDate,
                  style: TextStyle(color: Colors.black54, fontSize: 10.0)),
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
            )
          ],
        ),
        trailing:
        Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 30.0),
      ),
    );
  }
}
