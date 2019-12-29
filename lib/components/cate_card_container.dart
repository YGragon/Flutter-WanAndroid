/// 猫耳页面 一行 主布局
/// 作者 ：龙衣

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_wanandroid/components/cate_card_item.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import '../routers/application.dart';

/**
 * 每一个猫耳布局展示的内容
 */
class CateCardContainer extends StatelessWidget {
  final int columnCount; //一行几个
  final List<dynamic> categories;
  final bool isWidgetPoint;


  CateCardContainer(
      {Key key,
        @required this.categories,
        @required this.columnCount,
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
                  print("item--->"+item.toString());
                  /// 导航
                  /// 如果有 cats 集合 ，parentChapterId > -1 有子分类，进入子分类页面
                  /// 如果有 cats 集合 ，parentChapterId == -1 没有有子分类，进入列表页面
                  ///
                  /// 体系
                  /// 如果有 cats 集合 ，superChapterId > -1 有子分类，进入子分类页面
                  /// 如果有 cats 集合 ，superChapterId == -1 没有有子分类，进入列表页面
                  ///
                  /// 项目
                  /// 如果有 cats 集合 ，superChapterId > -1 有子分类，进入子分类页面
                  /// 如果有 cats 集合 ，superChapterId == -1 没有有子分类，进入列表页面

                  if(item.articles.isNotEmpty){
                    /// 导航页面
                    /// 跳转 category 页面：传递 id ,title
//                    Application.router.navigateTo(context, '${Routes.webViewPage}?id=${Uri.encodeComponent(itemId.toString())}&title=${Uri.encodeComponent(itemTitle)}');
//                    Application.router.navigateTo(context, "$targetRouter", transition: TransitionType.inFromRight);
                  }else if(item.cats.isNotEmpty){
                    /// 知识体系
                    /// 跳转 category 页面：传递 id ,title
                    Application.router.navigateTo(context, "/category/${item.name}", transition: TransitionType.inFromRight);
                  }else{
                    /// 项目
                    /// 点击直接进入 项目列表页面
                  }
//                  if (isWidgetPoint) {
//                    String targetName = item.name;
//                    String targetRouter = '/category/error/404';
//                    widgetDemosList.forEach((item) {
//                      if (item.name == targetName) {
//                        targetRouter = item.routerName;
//                      }
//                    });
//                    Application.router.navigateTo(context, "$targetRouter", transition: TransitionType.inFromRight);
//                  } else {
//                    Application.router.navigateTo(context, "/category/${item.name}", transition: TransitionType.inFromRight);
//                  }
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
