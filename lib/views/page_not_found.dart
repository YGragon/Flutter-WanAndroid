import 'package:flutter/material.dart';

/// 页面路由出错显示的页面
class PageNotFound extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("page not found"),
        ),
        body: Container(
            child:  Text("page not found")
        )
    );
  }
}
