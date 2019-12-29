import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/components/cate_card.dart';
import 'package:flutter_wanandroid/model/cat.dart';

/// 猫耳二级布局
/// 作者：龙衣

class CatSubPage extends StatefulWidget {
  final List<Cat> cats;
  final String name;

  CatSubPage({@required this.name, this.cats});

  @override
  _CatSubPageState createState() => _CatSubPageState();
}

class _CatSubPageState extends State<CatSubPage>
    with AutomaticKeepAliveClientMixin {
  TextEditingController controller;
  String active = 'test';
  String data = '无';
  StreamSubscription subscription;

  @override
  bool get wantKeepAlive => true;


  @override
  initState() {
    super.initState();
  }


  /// 构建网格布局
  Widget buildGrid() {
    // 存放最后的widget
    print("list----构建网格布局--->:" + widget.cats.toString());

    List<Widget> tiles = [];
    tiles.add(new CateCard(category: widget.name, categorieLists: widget.cats));
    return new ListView(
      children: tiles,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: this.buildGrid(),
        ));
  }
}
