import 'package:flutter/material.dart';

/// 导航文章列表

class NaviListPage extends StatefulWidget{

  final int id;
  final String title;

  NaviListPage(this.id, this.title);
  @override
  State<StatefulWidget> createState() {
    return new NaviListPageState();
  }

}

class NaviListPageState extends State<NaviListPage> {
  @override
  Widget build(BuildContext context) {
    return Text("导航文章列表");
  }
}