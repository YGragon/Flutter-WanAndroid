import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/api/common_service.dart';
import 'package:flutter_wanandroid/components/cate_card.dart';
import 'package:flutter_wanandroid/model/car.dart';

/// 猫耳布局
/// 展示 体系、项目、导航 三大分类
/// 作者：龙衣

class CatPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new CatPageState();
  }

}

class CatPageState extends State<CatPage> with AutomaticKeepAliveClientMixin {

  TextEditingController controller;
  String active = 'test';
  String data = '无';

  List<String> categories = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getCatPageData();
  }


  void _getCatPageData() {
    if (!mounted) {
      return;
    }
    if (categories.isEmpty) {
      categories.add("体系");
      categories.add("导航");
      categories.add("项目");
      setState(() {
        categories = categories;
      });
    }
  }
  /// 构建网格布局
  Widget buildGrid() {
    // 存放最后的widget
    List<Widget> tiles = [];
    for (String item in categories) {
      tiles.add(new CateCard(category: item));
    }
    return new ListView(
      children: tiles,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (categories.length == 0) {
      return ListView(
        children: <Widget>[new Container()],
      );
    }
    return Container(
      color: Theme.of(context).backgroundColor,
      child: this.buildGrid(),
    );
  }
}