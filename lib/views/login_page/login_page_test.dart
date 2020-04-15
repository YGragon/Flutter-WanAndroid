import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/routers/navigation_service.dart';
import 'package:flutter_wanandroid/widgets/loading/dialog_manager.dart';

class AnimationTestPage extends StatefulWidget {
  @override
  _AnimationTestPageState createState() {
    return _AnimationTestPageState();
  }
}

String mContext = '';

class _AnimationTestPageState extends State<AnimationTestPage> {
  void getHttp(BuildContext context) async {
    DioManager().get("http://www.baidu.com", showLoading: () {
      DialogManager.showBasicDialog(context, "正在加载中...");
    }, hideLoading: () {
      /// 关闭弹窗
      Navigator.pop(context);
    }, success: (data) {
      setState(() {
        mContext = data.toString();
      });
    }, error: (e) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dio"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              RaisedButton(
                child: Text('请求网络'),
                onPressed: () {
                  getHttp(context);
                },
              ),
              Text("请求网络返回的数据：\n$mContext")
            ],
          ),
        ));
  }
}

class Student {
  String id;
  String name;
  int score;

  Student({
    this.id,
    this.name,
    this.score,
  });
  factory Student.fromJson(Map<String, dynamic> parsedJson) {
    return Student(
      id: parsedJson['id'],
      name: parsedJson['name'],
      score: parsedJson['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'score': score,
    };
  }
}
