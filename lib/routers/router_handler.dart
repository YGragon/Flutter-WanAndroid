import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_wanandroid/components/navi_list.dart';
import 'package:flutter_wanandroid/components/project_list.dart';
import 'package:flutter_wanandroid/main_page.dart';
import 'package:flutter_wanandroid/model/cat.dart';
import 'package:flutter_wanandroid/views/about_page/about_page.dart';
import 'package:flutter_wanandroid/views/article_list_page/article_list_page.dart';
import 'package:flutter_wanandroid/views/cat_page/cat_sub_page.dart';
import 'package:flutter_wanandroid/views/coin_rank_page/coin_rank_page.dart';
import 'package:flutter_wanandroid/views/collection_page/collection_page.dart';
import 'package:flutter_wanandroid/views/home_page/home_page.dart';
import 'package:flutter_wanandroid/views/login_page/login_page.dart';
import 'package:flutter_wanandroid/views/my_collect_list_page/my_collect_list_page.dart';
import 'package:flutter_wanandroid/views/page_not_found.dart';
import 'package:flutter_wanandroid/views/photo_detail_page/photo_detail_page.dart';
import 'package:flutter_wanandroid/views/register_page/register_page.dart';
import 'package:flutter_wanandroid/views/web_page/webview_page.dart';

/// 命名路由参数传递，对应着 router.dart


/// home 页面
var homeHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return HomePage();
  },
);

/// app的首页
var rootHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return MainPage();
  },
);

/// 登录页面
var loginHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return LoginPage();
  },
);

/// 注册页面
var registerHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return RegisterPage();
  },
);

/// 关于页面
var aboutHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return AboutPage();
  },
);

/// 积分排行榜页面
var coinRankHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return CoinRankPage();
  },
);

/// 积分排行榜页面
var myCollectsHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return MyCollectListPage();
  },
);


/// 分类页面
var categoryHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String name = params["type"]?.first;

    return new CollectionPage();
  },
);

/// 子分类页面
var subCatHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String name = params["name"]?.first;
    // todo list string 如何传递
    List<Cat> cats = params["cats"]?.first as List<Cat>;

    return  CatSubPage(name:name, cats: cats,);
  },
);

/// 具体的体系列表
var treeListHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String id = params['id']?.first;
    String name = params['name']?.first;
    return new ArticleListPage(id:int.parse(id),name: name,);
  },
);

/// 导航页面
var naviListHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String id = params['id']?.first;
    String title = params['title']?.first;
    return new NaviListPage(int.parse(id), title);
  },
);

/// 项目页面
var projectHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String id = params['id']?.first;
    String title = params['title']?.first;
    return new ProjectListPage(int.parse(id), title);

  },
);
/// 找不到页面
var pageNotFoundHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new PageNotFound();
    });


/// 网页展示
var webViewPageHand = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id']?.first;
      String title = params['title']?.first;
      String link = params['link']?.first;
      return new WebViewPage(int.parse(id), title, link);
    });

/// 大图详情页面
var photoDetailPageHand = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id']?.first;
      String title = params['title']?.first;
      String desc = params['desc']?.first;
      String projectLink = params['projectLink']?.first;
      String envelopePic = params['envelopePic']?.first;
      String niceDate = params['niceDate']?.first;
      String author = params['author']?.first;
      return new PhotoDetailPage(id,title,desc,projectLink,envelopePic,niceDate,author);
    });
