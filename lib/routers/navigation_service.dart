import 'dart:async';

import 'package:flutter/material.dart';

/// 无 context 跳转页面
class NavigationService {
  NavigationService() {
    navigatorKey = GlobalKey<NavigatorState>();
  }

  GlobalKey<NavigatorState> navigatorKey;

  Future<T> navigateTo<T>(Route<T> route) {
    return navigatorKey.currentState.push<T>(route);
  }

  bool goBack() {
    return navigatorKey.currentState.pop();
  }
}