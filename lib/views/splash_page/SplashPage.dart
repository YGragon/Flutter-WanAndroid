import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/model/user.dart';
import 'package:flutter_wanandroid/routers/router_path.dart';

/// 闪屏页，首页之前的广告页面
class SplashPage extends StatefulWidget{
  @override
  _SplashPageState createState() => _SplashPageState();

}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    countDown();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
            child: Image(
              image: AssetImage('assets/images/flutter.png'),
              height: 96,
              width: 96,
            )));
  }

  //倒计时
  void countDown() {
    var _duration = Duration(seconds: 2);
    new Future.delayed(_duration, goHomePage);
  }

  //页面跳转
  void goHomePage() {
    print("判断跳转那个页面");
    User().getUserInfo().then((value){
      print("用户名："+ value);
      if(value.length > 0){
        Navigator.pushReplacementNamed(context, RouterPath.root);
      }else{
        Navigator.pushReplacementNamed(context, RouterPath.login);
      }
    });

  }
}
