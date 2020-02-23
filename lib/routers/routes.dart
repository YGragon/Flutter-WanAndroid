
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/widgets/error/error_page.dart';

import './router_handler.dart';

class Routes {
  static String root = "/";
  static String home = "/home";
  static String catSub = "/cat-sub";
  static String category = '/category';
  static String treeList = '/tree-list';
  static String naviList = '/navi-list';
  static String projectList = '/project-list';
  static String webViewPage = '/web-view-page';
  static String errorPage = '/error-page';

  static void configureRoutes(Router router) {
    // 首页
    router.define(home, handler: homeHandler);
    // 分类
//    router.define('/category/:type', handler: categoryHandler);
    // 详情页面
    router.define(webViewPage,handler:webViewPageHand);
    router.define(category,handler:categoryHandler);
    router.define(treeList,handler:treeListHandler);
    router.define(naviList,handler:naviListHandler);
    router.define(projectList,handler:projectHandler);

  }
}
