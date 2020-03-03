/// 首页列表流

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/api/common_service.dart';
import 'package:flutter_wanandroid/model/article.dart';
import 'package:flutter_wanandroid/widgets/loading/dialog_manager.dart';

class ListRefresh extends StatefulWidget {
  final renderItem;
  final headerView;

  const ListRefresh([this.renderItem, this.headerView]) : super();

  @override
  State<StatefulWidget> createState() => _ListRefreshState();
}

class _ListRefreshState extends State<ListRefresh> {
  bool isLoading = false; // 是否正在请求数据中
  bool _hasMore = true; // 是否还有更多数据可加载
  int _pageIndex = 0; // 页面的索引
  int _pageTotal = 0; // 页面的索引
  List items  = new List();
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    getArticleRequest();
    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

//  回弹效果
  backElasticEffect() {
//    print("模拟回弹效果");
//    double edge = 50.0;
//    double offsetFromBottom = _scrollController.position.maxScrollExtent - _scrollController.position.pixels;
//    if (offsetFromBottom < edge) { // 添加一个动画没有更多数据的时候 ListView 向下移动覆盖正在加载更多数据的标志
//      _scrollController.animateTo(
//          _scrollController.offset - (edge -offsetFromBottom),
//          duration: new Duration(milliseconds: 1000),
//          curve: Curves.easeOut);
//    }
  }

// list探底，执行的具体事件
  Future _getMoreData() async {
    _pageIndex++;
    if (!isLoading && _hasMore) {
      // 如果上一次异步请求数据完成 同时有数据可以加载
      if (mounted) {
        setState(() => isLoading = true);
      }
      //if(_hasMore){ // 还有数据可以拉新
      await getArticleRequest();
      _hasMore = (_pageIndex <= _pageTotal);
      if (this.mounted) {
        setState(() {
          isLoading = false;
        });
      }
      backElasticEffect();
    } else if (!isLoading && !_hasMore) {
      // 这样判断,减少以后的绘制
      _pageIndex = 0;
      backElasticEffect();
    }
  }

// 伪装吐出新数据
  Future getArticleRequest() async {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      DialogManager.showBasicDialog(context, "正在加载中...");
    });
    /// 获取新的数据
    CommonService().getArticleList((ArticleModel _articleModel){
      _pageTotal = _articleModel.data.total;
      setState(() {
        items.addAll(_articleModel.data.datas);
      });
      Navigator.pop(context);
    }, _pageIndex);
  }
// 下拉加载的事件，清空之前list内容，取前X个
// 其实就是列表重置
  Future _handleRefresh() async {
    _pageIndex = 0;
    if (this.mounted) {
      setState(() {
        isLoading = false;
        _hasMore = true;
      });
    }
    items.clear();
    getArticleRequest();

  }

// 加载中的提示
  Widget _buildLoadText() {
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Text("数据没有更多了！！！"),
          ),
        ));
  }

// 上提加载loading的widget,如果数据到达极限，显示没有更多
  Widget _buildProgressIndicator() {
    if (_hasMore) {
      return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
            child: Column(
              children: <Widget>[
                new Opacity(
                  opacity: isLoading ? 1.0 : 0.0,
                  child: new CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.blue)),
                ),
                SizedBox(height: 20.0),
                Text(
                  '稍等片刻更精彩...',
                  style: TextStyle(fontSize: 14.0),
                )
              ],
            )
          //child:
        ),
      );
    } else {
      return _buildLoadText();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      child: ListView.builder(
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index == 0 && index != items.length) {
            if(widget.headerView is Function){
              return widget.headerView();
            }else {
              return Container(height: 0);
            }
          }
          // 最后一条显示加载中指示器
          if (index == items.length) {
            //return _buildLoadText();
            return _buildProgressIndicator();
          }else {
//            print('itemsitemsitemsitems:${items[index - 1].title}');
            //return ListTile(title: Text("Index${index}:${items[index].title}"));
            // 渲染 Item
            if (widget.renderItem is Function) {
              return widget.renderItem(index - 1, items[index - 1]);
            }
          }
        },
        controller: _scrollController,
      ),
      onRefresh: _handleRefresh,
    );
  }
}
