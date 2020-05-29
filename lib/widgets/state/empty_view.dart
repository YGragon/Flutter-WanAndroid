import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wanandroid/constant/color_config.dart';

class EmptyView extends StatefulWidget {


  final VoidCallback emptyRetry; //无数据事件处理

  EmptyView(this.emptyRetry);

  @override
  _EmptyViewViewState createState() => _EmptyViewViewState();
}

class _EmptyViewViewState extends State<EmptyView> {

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: ScreenUtil().setWidth(750),
        height: double.infinity,
        child: InkWell(
          onTap: widget.emptyRetry,// 回调，重试
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
//                width: ScreenUtil().setWidth(405),
//                height: ScreenUtil().setHeight(281),
                child: Image.asset('assets/images/8021-empty-and-lost.gif'),
//                child: Image.asset('assets/images/p1.png'),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text('暂无相关数据,轻触重试~',style: TextStyle(color: ColorConfig.BLUE_200,fontSize: ScreenUtil().setSp(40)),)
            ],
          ),
        )
    );
  }
}
