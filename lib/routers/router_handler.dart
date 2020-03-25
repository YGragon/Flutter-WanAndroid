import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_wanandroid/components/navi_list.dart';
import 'package:flutter_wanandroid/components/project_list.dart';
import 'package:flutter_wanandroid/model/cat.dart';
import 'package:flutter_wanandroid/views/article_list_page/article_list_page.dart';
import 'package:flutter_wanandroid/views/cat_page/cat_page.dart';
import 'package:flutter_wanandroid/views/cat_page/cat_sub_page.dart';
import 'package:flutter_wanandroid/views/collection_page/collection_page.dart';
import 'package:flutter_wanandroid/views/home_page/home_page.dart';
import 'package:flutter_wanandroid/views/login_page/login_page_test.dart';
import 'package:flutter_wanandroid/views/page_not_found.dart';
import 'package:flutter_wanandroid/views/web_page/webview_page.dart';



// app的首页
var homeHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new HomePage();
  },
);

var categoryHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String name = params["type"]?.first;

    return new CollectionPage();
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

var naviListHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String id = params['id']?.first;
    String title = params['title']?.first;
    return new NaviListPage(int.parse(id), title);
  },
);

var projectHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String id = params['id']?.first;
    String title = params['title']?.first;
    return new ProjectListPage(int.parse(id), title);

  },
);
var pageNotFoundHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new PageNotFound();
    });

var thirdHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String msg = params['msg']?.first;
    return new ThridPage(msg);

  },
);


var webViewPageHand = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id']?.first;
      String title = params['title']?.first;
      String link = params['link']?.first;
      return new WebViewPage(int.parse(id), title, link);
    });
