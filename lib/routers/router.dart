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
    var mTransitiontype = TransitionType.inFromRight;
    // 首页
    router.define(RouterPath.root, handler: rootHandler);
    // home 页
    router.define(RouterPath.home, handler: homeHandler );
    // web页面
    router.define(RouterPath.webViewPage,handler:webViewPageHand, transitionType:mTransitiontype);
    router.define(RouterPath.category,handler:categoryHandler, transitionType:mTransitiontype);
    router.define(RouterPath.treeList,handler:treeListHandler, transitionType:mTransitiontype);
    router.define(RouterPath.naviList,handler:naviListHandler, transitionType:mTransitiontype);
    router.define(RouterPath.projectList,handler:projectHandler, transitionType:mTransitiontype);
    router.define(RouterPath.errorPage,handler:pageNotFoundHandler, transitionType:mTransitiontype);
    // 项目页面
    router.define(RouterPath.photoDetailPage,handler:photoDetailPageHand, transitionType:mTransitiontype);
    router.define(RouterPath.login,handler:loginHandler, transitionType:mTransitiontype);
    router.define(RouterPath.register,handler:registerHandler, transitionType:mTransitiontype);
    // 关于页面
    router.define(RouterPath.about,handler:aboutHandler, transitionType:mTransitiontype);
    router.define(RouterPath.coinRank,handler:coinRankHandler, transitionType:mTransitiontype);
    router.define(RouterPath.myCollect,handler:myCollectsHandler, transitionType:mTransitiontype);
    // 二级分类
    router.define(RouterPath.subCat,handler:subCatHandler, transitionType:mTransitiontype);
  }

}
