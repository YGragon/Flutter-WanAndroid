import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 自定义的崩溃页面
class ErrorPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("出了点问题"),
      ),
        body: Center(
          child: Text("出了点问题~\n我们会马上修复的。"),
        )
    );
  }

}