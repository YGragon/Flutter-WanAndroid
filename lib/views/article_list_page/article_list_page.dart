import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/api/common_service.dart';
import 'package:flutter_wanandroid/components/list_view_item.dart';
import 'package:flutter_wanandroid/model/article.dart';

/// 体系、项目、导航列表
class ArticleListPage extends StatefulWidget{

  final int id;
  final String name;
  ArticleListPage({@required this.id,this.name});

  @override
  _ArticleListPageState createState() => _ArticleListPageState();

}

class _ArticleListPageState extends State<ArticleListPage> {
  bool isLoading = false; // 是否正在请求数据中
  bool _hasMore = true; // 是否还有更多数据可加载
  int _pageIndex = 0; // 页面的索引
  int _pageTotal = 0; // 页面的索引
  List items  = new List();
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _getData(_pageIndex,widget.id);
    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  _getData(int page, int id){
    /// 获取体系数据
    CommonService().getSystemTreeContent((ArticleModel catModel) {
       items.addAll(catModel.data.datas);
       setState(() {
         items = items;
       });
    },page,id);
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
        setState(() => isLoading = false);
      }
//      backElasticEffect();
    } else if (!isLoading && !_hasMore) {
      // 这样判断,减少以后的绘制
      _pageIndex = 0;
//      backElasticEffect();
    }
  }

// 伪装吐出新数据
  Future getArticleRequest() async {
    /// 获取新的数据
    CommonService().getSystemTreeContent((ArticleModel catModel) {
      _pageTotal = catModel.data.pageCount;
      items.addAll(catModel.data.datas);
      _hasMore = (_pageIndex <= _pageTotal);
    },_pageIndex,widget.id);
  }

  /// 列表中的卡片item
  Widget makeCard(index,item){

    var mId = item.id;
    var mTitle = '${item.title}';
    var mShareUserName = '${'👲'}: ${item.shareUser} ';

    if(item.shareUser == ""){
      mShareUserName = '${'👲'}: ${item.author} ';
    }
    var mLikeUrl = '${item.link}';
    var mNiceDate = '${'🔔'}: ${item.niceDate}';
    return new ListViewItem(itemId: mId, itemTitle: mTitle, itemUrl:mLikeUrl,itemShareUser: mShareUserName, itemNiceDate: mNiceDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
        body: ListView.builder(
          itemCount: items.length + 1,
          itemBuilder: (context, index) {
            if (index == 0 && index != items.length) {
              return Container(height: 0);
            }
            // 最后一条显示加载中指示器
            if (index == items.length) {
              return _buildProgressIndicator();
            }else {
              // 渲染 Item
              return makeCard(index, items[index]);
            }
          },
          controller: _scrollController,
        ),
    );
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
}