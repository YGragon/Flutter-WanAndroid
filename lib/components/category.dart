/// 从 猫耳Tab 进入的 二级分类页面
/// 作者：龙衣

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/components/cate_card_container.dart';
import 'package:flutter_wanandroid/model/article.dart';
import 'package:flutter_wanandroid/model/cat.dart';

import '../routers/application.dart';


enum CategoryPage { Cat, WidgetDemo }

class CategoryHome extends StatefulWidget {
  CategoryHome(this.id, this.title);
  final int id;
  final String title;

  @override
  _CategoryHome createState() => new _CategoryHome();
}

class _CategoryHome extends State<CategoryHome> {
  String title = '';

  List<Cat> cats = [];
  /// 分类层级
  List<Cat> catHistory = new List();


  @override
  void initState() {
    super.initState();
    // 初始化加入顶级的name
    /// 请求网络，通过 id 去获取，当前下面的 children 是否有数据
//    this.getCatByName(widget.name).then((Cat cat) {
//      catHistory.add(cat);
//      searchCatOrWigdet();
//    });
  }


  Future<bool> back() {
    if (catHistory.length == 1) {
      return Future<bool>.value(true);
    }
    catHistory.removeLast();
    searchCatOrWigdet();
    return Future<bool>.value(false);
  }

  void go(Cat cat) {
    catHistory.add(cat);
    searchCatOrWigdet();
  }

  void searchCatOrWigdet() async {

    List<Cat> _cats = new List();


    this.setState(() {
      cats = _cats;
    });
  }

  void onCatgoryTap(Cat cat) {
    go(cat);
  }

  /// item 点击
  void onWidgetTap(Cat cat) {
    /// 如果 cats 不空
    /// 跳转 category 页面：传递 id ,title
//    Application.router.navigateTo(context, "$targetRouter");
  }

  /// 内容显示
  Widget _buildContent() {
    CateCardContainer wiContaienr = CateCardContainer(
          categories: cats,
          columnCount: 3,
          isWidgetPoint:true
      );
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage('assets/images/paimaiLogo.png'),
            alignment: Alignment.bottomRight),
      ),
      child: wiContaienr,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: WillPopScope(
        onWillPop: () {
          return back();
        },
        child: ListView(
          children: <Widget>[
            _buildContent(),
          ],
        ),
        // child: Container(color: Colors.blue,child: Text('123'),),
      ),
    );
  }
}

