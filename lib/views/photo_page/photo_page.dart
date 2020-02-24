import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_wanandroid/api/common_service.dart';
import 'package:flutter_wanandroid/components/search_input.dart';
import 'package:flutter_wanandroid/model/project_model.dart';
import 'package:flutter_wanandroid/views/photo_page/item_card.dart';

class PhotoPage extends StatefulWidget {
  @override
  _PhotoPageState createState() => new _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
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

  /// TODO 抽取出去 联想搜索，显示搜索结果列表
  Widget buildSearchInput(BuildContext context) {
    return new SearchInput((value) async {
      if (value != '') {
        // TODO 发起网络请求，搜索结果
        print("---------------->>>>>>>" + value);
      } else {
        return null;
      }
    }, (value) {}, () {});
  }

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
    /// 获取新的数据
    CommonService().getProjectList((ProjectModel _projectModel) {
      _pageTotal = _projectModel.data.total;
      setState(() {
        items.addAll(_projectModel.data.datas);
      });
    }, _page, _projectId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: buildSearchInput(context),
        ),
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
