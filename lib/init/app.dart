import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_wanandroid/generated/i18n.dart';
import 'package:flutter_wanandroid/model/search_history.dart';
import 'package:flutter_wanandroid/model/store.dart';
import 'package:flutter_wanandroid/model/theme.dart';
import 'package:flutter_wanandroid/routers/application.dart';
import 'package:flutter_wanandroid/routers/navigation_service.dart';
import 'package:flutter_wanandroid/routers/router.dart';
import 'package:flutter_wanandroid/utils/provider.dart';
import 'package:flutter_wanandroid/utils/shared_preferences.dart';
import 'package:flutter_wanandroid/views/page_not_found.dart';
import 'package:flutter_wanandroid/views/splash_page/SplashPage.dart';
import 'package:provider/provider.dart';

class App{
  //运行app
  static void run() {
    WidgetsFlutterBinding.ensureInitialized();


    /// 全局 provider 初始化
    runZoned<Future<Null>>(() async {
      /// 全局 provider 初始化
      SPUtils.init().then((value) => runApp(Store.init(MyApp())));
      initApp();

    });


  }



  //程序初始化操作
  static void initApp() {
    // SP 初始化
    SPUtils.init();
    // 搜索历史
    SearchHistoryList();

    DBProvider().init(true);
//    XHttp.init();
    XRouter.init();
//    SQLHelper.init();
//    XPush.init();
//    Bugly.init();
//    UMeng.init();
  }
}
//@override
//void initState() {
//  if (Platform.isAndroid) {
//    FlutterCrashPlugin.setUp('43eed8b173');
//  } else if (Platform.isIOS) {
//    FlutterCrashPlugin.setUp('088aebe0d5');
//  }
//  final eventBus = new EventBus();
//  Application.eventBus = eventBus;
//
//  super.initState();
//}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
        builder: (context, appTheme, _) {
          return MaterialApp(
                title: 'Wan-Android',
                navigatorKey: NavigationService.navigatorKey,
                theme: appTheme.themeDate,//根据平台选择不同主题
                localizationsDelegates: [
                  S.delegate,//应用程序的翻译回调
                  // 本地化的代理类
                  GlobalMaterialLocalizations.delegate,//Material组件的翻译回调
                  GlobalWidgetsLocalizations.delegate,//普通Widget的翻译回调
                ],
                supportedLocales: S.delegate.supportedLocales,//支持语系
                // title的国际化回调
                onGenerateTitle: (context){ return S.of(context).app_title; },
                // 闪屏页
                home:Scaffold(body: SplashPage()),
                // 生成路由的回调函数，当导航的命名路由的时候，会使用这个来生成界面
                onGenerateRoute: Application.router.generator,
                // 页面找不到显示的 404 页面
                onUnknownRoute: (RouteSettings setting) =>
                    MaterialPageRoute(builder: (context) => PageNotFound()),
              );
            },
        );
  }
}