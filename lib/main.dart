import 'dart:async';
import 'dart:io';

import 'package:event_bus/event_bus.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wanandroid/main_page.dart';
import 'package:flutter_wanandroid/model/search_history.dart';
import 'package:flutter_wanandroid/routers/application.dart';
import 'package:flutter_wanandroid/routers/navigation_service.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/provider.dart';
import 'package:flutter_wanandroid/utils/shared_preferences.dart';
import 'package:flutter_wanandroid/views/page_not_found.dart';
import 'package:flutter_wanandroid/widgets/error/error_page.dart';
import 'package:flutter_wanandroid/widgets/error/flutter_crash_plugin.dart';

import 'event/event_theme.dart';

// 主题颜色为红色
int ThemeColor = 0xFFC91B3A;

SpUtil sp;
var db;

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}
/// Reports [error] along with its [stackTrace] to Bugly.
Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
  print('崩溃异常信息: $error');

  print('Reporting to Bugly...');
//  _showErrorPage();

//  FlutterCrashPlugin.postException(error, stackTrace);
}

/// 无 context 跳转错误页面
_showErrorPage() {
  NavigationService.navigatorKey.currentState.push(MaterialPageRoute(
    builder: (context) => ErrorPage(),
  ));
}




Future<Null> main() async {
  // 初始化之前出现白屏
  WidgetsFlutterBinding.ensureInitialized();
  // 创建数据库
  final provider = new Provider();
  // 数据库初始化
  await provider.init(true);
  // 获取 SP 对象
  sp = await SpUtil.getInstance();
  // 得到单例对象的 搜索 管理对象
  new SearchHistoryList(sp);

  db = Provider.db;

  // This captures errors reported by the Flutter framework.
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (isInDebugMode) {
      // debug模式直接打印在控制台
      FlutterError.dumpErrorToConsole(details);
    } else {
      // 在生产模式下,重定向到 runZone 中处理
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
    //上报错误和日志逻辑
    _reportError(details.exception, details.stack);
  };

  // 重写异常页面
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    print(flutterErrorDetails.toString());
    return Scaffold(
        body: Center(
              child: Text("出了点问题，我们马上修复~"),
    ));
  };

  runZoned<Future<Null>>(() async {
    runApp(new MyApp());
  }, onError: (error, stackTrace) async {
    await _reportError(error, stackTrace);
  });
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    if (Platform.isAndroid) {
      FlutterCrashPlugin.setUp('43eed8b173');
    } else if (Platform.isIOS) {
      FlutterCrashPlugin.setUp('088aebe0d5');
    }
    final eventBus = new EventBus();

    final router = new Router();
    // 初始化路由
    Routes.configureRoutes(router);

    Application.router = router;
    Application.eventBus = eventBus;

    // 监听数据变化
    Application.eventBus.on<ThemeEvent>().listen((event) {
      setState(() {
        ThemeColor = event.themeColor;
      });
    });
    super.initState();
  }

  _showWelcomePage() {
    // 暂时关掉欢迎介绍，直接跳转首页
    return MainPage();
  }

  @override
  Widget build(BuildContext context) {

    // iOS浅色主题
    final ThemeData kIOSTheme = ThemeData(
        brightness: Brightness.dark,//亮色主题
        accentColor: Color(0xFF888888),//(按钮)Widget前景色为白色
        primaryColor: Colors.blue,//主题色为蓝色
        backgroundColor: Color(0xFFEFEFEF), // 背景色为灰色
        iconTheme:IconThemeData(color: Colors.grey, size: 35.0),//icon主题为灰色
        textTheme: TextTheme(body1: TextStyle(color: Colors.black, fontSize: 16.0))//文本主题为黑色
    );

    // Android深色主题
    final ThemeData kAndroidTheme = ThemeData(
        brightness: Brightness.light,//深色主题
        accentColor: Color(0xFF888888),//(按钮)Widget前景色为黑色
        primaryColor: Color(ThemeColor),//主题色Wie青色
        backgroundColor: Color(0xFFEFEFEF), // 背景色为灰色
        iconTheme:IconThemeData(color: Color(ThemeColor), size: 35.0),//icon主题色为蓝色
        textTheme: TextTheme(body1: TextStyle(color: Color(0xFF888888), fontSize: 16.0))//文本主题色为红色
    );


    return new MaterialApp(
      title: 'Wan-Android',
      navigatorKey: NavigationService.navigatorKey,
      theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme :kAndroidTheme,//根据平台选择不同主题
      home: new Scaffold(body: _showWelcomePage()),
      // 生成路由的回调函数，当导航的命名路由的时候，会使用这个来生成界面
      onGenerateRoute: Application.router.generator,
      // 页面找不到显示的 404 页面
      onUnknownRoute: (RouteSettings setting) =>
          MaterialPageRoute(builder: (context) => PageNotFound()),
    );
  }
}
