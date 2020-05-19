import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:flutter_wanandroid/init/app.dart';

/// 应用初始化
class AppInit{
  static void run() {
//    catchException(() => App.run());
    // //Bugly的异常捕获上传
    // Bugly.postCatchedException(() => NormalApp.run());

    /// 程序的主入口
    FlutterBugly.postCatchedException((){
      /// bugly 数据上报
      App.run();
    });

  }

  /// 异常捕获处理
  static void catchException<T>(T callback()) {

    /// 捕获异常的回调
    FlutterError.onError = (FlutterErrorDetails details) {
      reportErrorAndLog(details);
    };
    runZoned<Future<Null>>(() async {
        callback();
      },
      zoneSpecification: ZoneSpecification(
        print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
          /// 收集日志
          collectLog(parent, zone, line);
        },
      ),
      /// 未捕获的异常的回调
      onError: (Object obj, StackTrace stack) {
        var details = makeDetails(obj, stack);
        reportErrorAndLog(details);
      },
    );

    ///  重写异常页面
    ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
      print(flutterErrorDetails.toString());
      return Scaffold(
          body: Center(
            child: Text("出了点问题，我们马上修复~"),
          ));
    };
  }


  /// 日志拦截, 收集日志
  static void collectLog(ZoneDelegate parent, Zone zone, String line) {
    parent.print(zone, "日志拦截: $line");
  }

  /// 上报错误和日志逻辑
  static void reportErrorAndLog(FlutterErrorDetails details) {
    print('上报错误和日志逻辑: $details');
    print(details);
  }

  ///  构建错误信息
  static FlutterErrorDetails makeDetails(Object obj, StackTrace stack) {
    return FlutterErrorDetails(stack: stack);
  }


}