import 'package:flutter/material.dart';

/// 跨 widget 状态管理封装
class IProvider<T> extends InheritedWidget {
  // 数据
  final T data;
  // 方法
  final Function() doSomeThing;

  IProvider({Key key, Widget child, this.data,  this.doSomeThing})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(IProvider oldWidget) {
    return data != oldWidget.data;
  }
  static IProvider<T> of<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<IProvider<T>>();
  }
}