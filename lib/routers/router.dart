import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/routers/application.dart';
import 'package:flutter_wanandroid/routers/router_handler.dart';
import 'package:flutter_wanandroid/routers/router_path.dart';

class XRouter {
  static Router router;


  static void init() {
    router = Router();
    Application.router = router;
    configureRoutes(router);
  }

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("route is not find !");
          return null;
        });
    // 首页
    router.define(RouterPath.root, handler: rootHandler );
    // home 页
    router.define(RouterPath.home, handler: homeHandler );
    // 详情页面
    router.define(RouterPath.webViewPage,handler:webViewPageHand, transitionType:TransitionType.inFromLeft);
    router.define(RouterPath.category,handler:categoryHandler, transitionType:TransitionType.inFromLeft);
    router.define(RouterPath.treeList,handler:treeListHandler, transitionType:TransitionType.inFromLeft);
    router.define(RouterPath.naviList,handler:naviListHandler, transitionType:TransitionType.inFromLeft);
    router.define(RouterPath.projectList,handler:projectHandler, transitionType:TransitionType.inFromLeft);
    router.define(RouterPath.errorPage,handler:pageNotFoundHandler, transitionType:TransitionType.inFromLeft);
    router.define(RouterPath.photoDetailPage,handler:photoDetailPageHand, transitionType:TransitionType.inFromLeft);
    router.define(RouterPath.login,handler:loginHandler, transitionType:TransitionType.inFromLeft);
    router.define(RouterPath.register,handler:registerHandler, transitionType:TransitionType.inFromLeft);
  }

}
