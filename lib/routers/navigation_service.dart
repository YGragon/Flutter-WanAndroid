import 'dart:async';

import 'package:flutter/material.dart';

/// 无 context 跳转页面
class NavigationService {

  static GlobalKey<NavigatorState> navigatorKey =  GlobalKey<NavigatorState>();
  /// 全局 context
  static dynamic mContext;
//
//  static Future<T> navigateTo<T>(Route<T> route) {
//    return navigatorKey.currentState.push<T>(route);
//  }
//
//  static bool goBack() {
//    return navigatorKey.currentState.pop();
//  }
}