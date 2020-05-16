import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_wanandroid/api/common_service.dart';
import 'package:flutter_wanandroid/components/search_input.dart';
import 'package:flutter_wanandroid/model/project_model.dart';
import 'package:flutter_wanandroid/routers/navigation_service.dart';
import 'package:flutter_wanandroid/views/photo_page/item_card.dart';
import 'package:flutter_wanandroid/views/search_page/search_page.dart';
import 'package:flutter_wanandroid/widgets/loading/dialog_manager.dart';

class PhotoPage extends StatefulWidget {
  @override
  _PhotoPageState createState() => new _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage>  with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  // 当前页码
  int _page = 1;
  // 每页请求的个数
  int _size = 10;
  // 完整项目的id
  int _projectId = 294;
  // 总页码
  int _pageTotal = 0;
  List<DatasListBean> items = new List();
  var _scrollController = new ScrollController(initialScrollOffset: 0);


  @override
  void initState() {
    super.initState();

    /// 首次拉取数据
    _getProjectData(true);

    _scrollController.addListener(() {
      var px = _scrollController.position.pixels;
      if (px == _scrollController.position.maxScrollExtent) {
        print("加载更多！");
        _addMoreData();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();


  }

  /// 下拉刷新数据
  Future<Null> _refreshData() async {
    _page = 0;
    _getProjectData(false);
  }

  /// 上拉加载数据
  Future<Null> _addMoreData() async {
    _page++;
    _getProjectData(true);
  }

  /// 获取项目数据
  void _getProjectData(bool _isAdd) async {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      DialogManager.showBasicDialog(NavigationService.mContext, "正在加载中...");
    });
    /// 获取新的数据
    CommonService().getProjectList((ProjectModel _projectModel) {
      _pageTotal = _projectModel.data.total;
      if(mounted){
        setState(() {
          items.addAll(_projectModel.data.datas);
        });
      }
      /// 关闭弹窗
      Navigator.pop(NavigationService.mContext);
    }, _page, _projectId);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: new AppBar(title: SearchPage(),),
        body: Column(
          children: <Widget>[
            Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshData,
                  child:  StaggeredGridView.countBuilder(
                    controller: _scrollController,
                    padding: EdgeInsets.all(8),
                    itemCount: items.length,
                    crossAxisCount: 4,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 4.0,
                    itemBuilder: (context, index) => TileCard(
                        id: '${items[index].id}',
                        envelopePic: '${items[index].envelopePic}',
                        title: '${items[index].title}',
                        desc: '${items[index].desc}',
                        author: '${items[index].author}',
                        projectLink: '${items[index].projectLink}',
                        link: '${items[index].link}',
                        niceDate: '${items[index].niceDate}'),
                    staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                  ),
                )
            )
          ],
        )
    );
  }
}
