
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import './router_handler.dart';

class Routes {
  static String root = "/";
  static String home = "/home";
  static String widgetDemo = '/widget-demo';
  static String codeView = '/code-view';
  static String webViewPage = '/web-view-page';

  static void configureRoutes(Router router) {
    // 路径出错页面
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        });
    // 首页
    router.define(home, handler: homeHandler);
    // 分类
    router.define('/category/:type', handler: categoryHandler);
    // 404 页面
//    router.define('/category/error/404', handler: widgetNotFoundHandler);
    // 详情页面
    router.define(webViewPage,handler:webViewPageHand);

  }
}
