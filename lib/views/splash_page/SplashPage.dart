import 'dart:async';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/api/common_service.dart';
import 'package:flutter_wanandroid/model/user.dart';
import 'package:flutter_wanandroid/routers/router_path.dart';

/// 闪屏页，首页之前的广告页面
class SplashPage extends StatefulWidget{
  @override
  _SplashPageState createState() => _SplashPageState();

}

class _SplashPageState extends State<SplashPage> {
  // splash 默认图片
  var mImagesUrl = '';
  Timer _timer;
  int _countdownTime = 3;

  @override
  void initState() {
    super.initState();

    getSplashImage();
    startCountdownTimer();

  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  /// 倒计时
  void startCountdownTimer() {
    const duration = const Duration(seconds: 3);
    var callback = (timer) => {
      setState(() {
        if (_countdownTime > 0) {
          _countdownTime --;
        } else {
          _timer.cancel();
          goHomePage();
        }
      })
    };

    _timer = Timer.periodic(duration, callback);
  }

  /// 获取 splash 图片
  void getSplashImage(){
    CommonService().splash((String imageUrl) {
      setState(() {
        mImagesUrl = "https://cn.bing.com/" + imageUrl ;
        print("图片mImagesUrl：$mImagesUrl");
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          child:  ExtendedImage.network(
            mImagesUrl,
            enableLoadState: false,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          right: 38.0,
          bottom:50.0,
          child: RaisedButton(
            color: Colors.blue, // 按钮背景色
            highlightColor: Colors.blue[700],// 按钮高亮后的背景色
            colorBrightness: Brightness.dark,// 使用深色主题，保证按钮文字颜色为浅色
            splashColor: Colors.grey,// 点击时，水波动画中水波的颜色
            child: Text('$_countdownTime s'),// 文本
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //圆角矩形
            onPressed: () {},
          ),
        ),
      ],);
  }


  //页面跳转
  void goHomePage() {
    print("判断跳转那个页面");
    User().getUserInfo().then((value){
      if(value != null && value.length > 0){
        print("首页");

        Navigator.pushReplacementNamed(context, RouterPath.root);
      }else{
        print("登录页面");

        Navigator.pushReplacementNamed(context, RouterPath.login);
      }
    });

  }
}
