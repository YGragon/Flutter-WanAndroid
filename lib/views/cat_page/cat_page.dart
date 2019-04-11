import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 猫耳布局
/// 展示 体系、项目、导航 三大分类
/// 作者：龙衣

class CatPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new CatPageState();
  }

}

class CatPageState extends State<CatPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Text("猫耳布局"),
    );
  }
}