import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid/api/common_service.dart';
import 'package:flutter_wanandroid/model/article.dart';
import 'package:flutter_wanandroid/model/collect.dart';
import 'package:flutter_wanandroid/routers/application.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/views/login_page/login_page.dart';

class MyCollectListPage extends StatefulWidget {
  @override
  _MyCollectListPageState createState() => new _MyCollectListPageState();
}

class _MyCollectListPageState extends State<MyCollectListPage> {
  EasyRefreshController _controller;
  ScrollController _scrollController;

  // 条目总数
  int _totalCount = 0;
  // 页码
  int _page = 0;
  // 方向
  Axis _direction = Axis.vertical;
  // Header浮动
  bool _headerFloat = false;
  // 无限加载
  bool _enableInfiniteLoad = true;
  // 控制结束
  bool _enableControlFinish = false;
  // 是否开启刷新
  bool _enableRefresh = true;
  // 是否开启加载
  bool _enableLoad = true;
  // 顶部回弹
  bool _topBouncing = true;
  // 底部回弹
  bool _bottomBouncing = true;

  List<Article> _collectionList = [];

  @override
  void initState() {
    super.initState();
    _getCollectList();
    _controller = EasyRefreshController();
    _scrollController = ScrollController();
  }

  void _getCollectList() {
    /// 获取新的数据
    CommonService().getMyCollectList((ArticleModel _articleModel) {
      if (mounted) {
        if (_articleModel.errorCode == -1001) {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        } else {
          _totalCount = _articleModel.data.total;
          setState(() {
            _collectionList.addAll(_articleModel.data.datas);
          });
          if(_totalCount == _collectionList.length){
            _enableLoad = false;
          }
        }
      }
    }, _page);
  }

  Widget _renderList(context, index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      margin: const EdgeInsets.only(bottom: 7.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            color: const Color(0xFFd0d0d0),
            blurRadius: 1.0,
            spreadRadius: 2.0,
            offset: Offset(3.0, 2.0),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          _collectionList[index].title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 17.0),
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 30.0),
        onTap: () {
          // 需要转义 Uri.encodeComponent
          var collection = _collectionList[index];
          Application.router.navigateTo(context,
              '${Routes.webViewPage}?id=${Uri.encodeComponent(collection.id.toString())}&title=${Uri.encodeComponent(collection.title)}&link=${Uri.encodeComponent(collection.link)}');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('我的收藏'),
        ),
        body: Center(
          child: Container(
            height: _direction == Axis.vertical ? double.infinity : 210.0,
            child: EasyRefresh.custom(
              enableControlFinishRefresh: true,
              enableControlFinishLoad: true,
              controller: _controller,
              scrollController: _scrollController,
              scrollDirection: _direction,
              topBouncing: _topBouncing,
              bottomBouncing: _bottomBouncing,
              header: ClassicalHeader(
                enableInfiniteRefresh: false,
                bgColor: _headerFloat ? Theme.of(context).primaryColor : null,
                infoColor: _headerFloat ? Colors.black87 : Colors.teal,
                float: _headerFloat,
              ),
              footer: ClassicalFooter(
                enableInfiniteLoad: _enableInfiniteLoad,
              ),
              onRefresh: _enableRefresh
                  ? () async {
                      _page = 0;
                      _enableLoad = true;
                      _getCollectList();
                      if (!_enableControlFinish) {
                        _controller.resetLoadState();
                        _controller.finishRefresh();
                      }
                    }
                  : null,
              onLoad: _enableLoad
                  ? () async {
                      _page++;
                      _getCollectList();
                      if (!_enableControlFinish) {
                        _controller.finishLoad();
                      }
                    }
                  : null,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _renderList(context, index);
                    },
                    childCount: _collectionList.length,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
