import 'dart:convert';
import 'dart:math';

/// 猫耳页面 一行 主布局
/// 作者 ：龙衣

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_wanandroid/components/cate_card_item.dart';
import 'package:flutter_wanandroid/model/article.dart';
import 'package:flutter_wanandroid/model/cat.dart';
import 'package:flutter_wanandroid/model/navi_bean.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/views/cat_page/cat_sub_page.dart';
import '../routers/application.dart';

/// 每一个猫耳布局展示的内容
class CateCardContainer extends StatelessWidget {
  final int columnCount; //一行几个
  final List<dynamic> categories;
  final bool isWidgetPoint;
  final int type; // 0表示导航，其他表示体系和项目


  CateCardContainer(
      {Key key,
        @required this.categories,
        @required this.columnCount,
        @required this.type,
        @required this.isWidgetPoint})
      : super(key: key);

  List<Widget> _buildColumns(context) {
    List<Widget> _listWidget = [];
    List<Widget> _listRows = [];
    int addI;
    for (int i = 0, length = categories.length; i < length; i += columnCount) {
      _listRows = [];
      for (int innerI = 0; innerI < columnCount; innerI++) {
        addI = innerI + i;
        if (addI < length) {
          dynamic item = categories[addI];
          _listRows.add(
            Expanded(
              flex: 1,
              child: CateCardItem(
                title: item.name,
                onTap: () {
                  /// 导航
                  /// 如果有 articles 集合 进入列表页面
                  ///
                  /// 项目，体系
                  /// 如果有 cats 集合 ，有子分类，进入子分类页面
                  /// 如果有 cats 集合 ，进入列表页面
                  if(type == 0){
                    // 导航
                    var articles = item.articles as List<NaviArticle> ;
                    var name = item.name;
                    var cid = item.cid;
                    print("articles--->"+articles.toString());
                    if(articles != null){
                      // 项目，体系
                      Application.router.navigateTo(context, "${Routes.treeList}?id=${Uri.encodeComponent(cid.toString())}&name=${Uri.encodeComponent(name.toString())}", transition: TransitionType.inFromRight);
                    }
                  }else{
                    var cats = item.cats as List<Cat> ;
                    print("cats--->"+cats.toString());
                    if(cats != null){
                      // 项目，体系
                      if(cats.isNotEmpty){
                        // 继续显示猫耳朵
                        print("跳转猫耳-- 传递list->"+cats.toString());
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CatSubPage(name:item.name, cats: cats,)));
                      }else{
                        Application.router.navigateTo(context, "${Routes.treeList}?id=${Uri.encodeComponent(item.id.toString())}&name=${Uri.encodeComponent(item.name.toString())}", transition: TransitionType.inFromRight);
                      }
                    }
                  }

                },
                index: addI,
                totalCount: length,
                rowLength: columnCount,
                textSize: isWidgetPoint ? 'middle' : 'small',
              ),
            ),
          );
        } else {
          _listRows.add(
            Expanded(
              flex: 1,
              child: Container(),
            ),
          );
        }
      }
      _listWidget.add(
        Row(
          children: _listRows,
        ),
      );
    }
    return _listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildColumns(context),
    );
  }
}
