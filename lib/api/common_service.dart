import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/api/Api.dart';
import 'package:flutter_wanandroid/model/article.dart';
import 'package:flutter_wanandroid/model/banner.dart';
import 'package:flutter_wanandroid/model/cat.dart';
import 'package:flutter_wanandroid/model/navi_bean.dart';
import 'package:flutter_wanandroid/model/user.dart';
import 'package:flutter_wanandroid/net/dio_manager.dart';

class CommonService{

  Options _getOptions() {
    Map<String,String> map = new Map();
    List<String> cookies = User().cookie;
    map["Cookie"] = cookies.toString();
    map["responseType"] = "ResponseType.json";
    return Options(headers: map);
  }

  /// 获取首页 banner 数据
  void getBanner(Function callback) async {
    DioManager.singleton.dio.get(Api.HOME_BANNER, options: _getOptions()).then((response) {
      callback(BannerModel(response.data));
    });
  }

  /// 获取首页文章列表
  void getArticleList(Function callback,int _page) async {
    print("url: "+Api.HOME_ARTICLE_LIST+"$_page/json");
    DioManager.singleton.dio.get(Api.HOME_ARTICLE_LIST+"$_page/json", options: _getOptions()).then((response) {
      callback(ArticleModel(response.data));
    });
  }

  /// 获取知识体系列表
  void getSystemTree(Function callback) async {
    DioManager.singleton.dio.get(Api.SYSTEM_TREE, options: _getOptions()).then((response) {
      print("返回的体系列表 response.data："+response.data.toString());
      callback(CatModel(response.data));
    });
  }
  /// 获取知识体系列表详情
  void getSystemTreeContent(Function callback,int _page,int _id) async {
      print("url："+Api.SYSTEM_TREE_CONTENT+"$_page/json?cid=$_id");
    DioManager.singleton.dio.get(Api.SYSTEM_TREE_CONTENT+"$_page/json?cid=$_id", options: _getOptions()).then((response) {
      callback(ArticleModel(response.data));
    });
  }
  /// 获取导航列表数据
  void getNaviList(Function callback) async {
    DioManager.singleton.dio.get(Api.NAVI_LIST, options: _getOptions()).then((response) {
      print("获取导航列表数据 ："+response.toString());
      callback(NaviBeanModel(response.toString()));
    });
  }
  /// 获取项目分类
  void getProjectTree(Function callback) async {
    DioManager.singleton.dio.get(Api.PROJECT_TREE, options: _getOptions()).then((response) {
      print("获取项目分类 response.data："+response.data.toString());
      callback(CatModel(response.data));
    });
  }
  /// 获取项目列表
//  void getProjectList(Function callback,int _page,int _id) async {
//    DioManager.singleton.dio.get(Api.PROJECT_LIST+"$_page/json?cid=$_id", options: _getOptions()).then((response) {
//      callback(ProjectTreeListModel(response.data));
//    });
//  }
}