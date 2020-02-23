import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/main_page.dart';
import 'package:flutter_wanandroid/routers/application.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/provider.dart';
import 'package:flutter_wanandroid/utils/shared_preferences.dart';


const int ThemeColor = 0xFFC91B3A;
SpUtil sp;
var db;


void main() async {
  // 初始化之前出现白屏
  WidgetsFlutterBinding.ensureInitialized();
  // 创建数据库
  final provider = new Provider();
  // 数据库初始化
  await provider.init(true);
  // 获取 SP 对象
  sp = await SpUtil.getInstance();
  // 得到单例对象的 搜索 管理对象
//  new SearchHistoryList(sp);

  db = Provider.db;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  MyApp(){
    final router = new Router();
    // 初始化路由
    Routes.configureRoutes(router);

    Application.router = router;
  }

  showWelcomePage() {
    // 暂时关掉欢迎介绍
    return MainPage();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'title',
      theme: new ThemeData(
        primaryColor: Color(ThemeColor),
        backgroundColor: Color(0xFFEFEFEF),
        accentColor: Color(0xFF888888),
        textTheme: TextTheme(
          //设置Material的默认字体样式
          body1: TextStyle(color: Color(0xFF888888), fontSize: 16.0),
        ),
        iconTheme: IconThemeData(
          color: Color(ThemeColor),
          size: 35.0,
        ),
      ),
      home: new Scaffold(
          body: showWelcomePage()
      ),
      // 生成路由的回调函数，当导航的命名路由的时候，会使用这个来生成界面
      onGenerateRoute: Application.router.generator,
    );
  }
}
