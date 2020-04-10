import 'package:flutter/material.dart';

class AnimationTestPage extends StatefulWidget {
  @override
  _AnimationTestPageState createState() {
    return _AnimationTestPageState();
  }
}

class _AnimationTestPageState extends State<AnimationTestPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    // 创建动画周期为1秒的AnimationController对象
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    // 创建线性变化的 Animation 对象
    animation = Tween(begin: 10.0, end: 100.0).animate(controller);

    //让动画重复执行
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose(); // 释放资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("AnimationTest"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
//              RaisedButton(
//                onPressed: () {
//                  Navigator.of(context).push(
//                      MaterialPageRoute(builder: (_) => Page1())); //点击后打开第二个页面
//                },
//                child: Text('Hero'),
//              ),
              Center(
                  child: AnimatedFadeFlutterLogo(
                      controller: controller) // 初始化 AnimatedWidget 时传入animation对象
                  ),
              Center(
                  child: AnimatedFlutterLogoBuilder(
                    child: Image.network(
                        'https://hbimg.huabanimg.com/fced2db29a9354db4747822b819b247d88adbb9be837-bB3TR0_fw658'),
                    controller: controller,
                    animation: animation,
                  ))
            ],
          ),
        ));
  }
}
class AnimatedFlutterLogoBuilder extends StatelessWidget{
  final Widget child;
  final AnimationController controller;
  final Animation<double> animation;

  AnimatedFlutterLogoBuilder({this.child,this.controller,this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation, // 传入动画对象
        child: child,
        // 动画构建回调
        builder: (context, child) => FadeTransition(
          opacity: controller,
          child: Container(
            width: animation.value, //使用动画的当前状态更新UI
            height: animation.value,
            child: child, // 即 AnimatedBuilder 中的 child
          ),
        ));
  }
}

/// 使用 AnimatedWidget 创建动画
class AnimatedFlutterLogo extends AnimatedWidget {
  // AnimatedWidget 需要在初始化时传入animation对象，所以构造函数不能少
  AnimatedFlutterLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    // 取出动画对象
    final Animation<double> animation = listenable;
    return Center(
      child: Container(
        height: animation.value, //根据动画对象的当前状态更新宽高
        width: animation.value,
        child: Image.network(
            'https://hbimg.huabanimg.com/fced2db29a9354db4747822b819b247d88adbb9be837-bB3TR0_fw658'),
      ),
    );
  }
}

/// 使用 AnimatedWidget 创建动画
class AnimatedFadeFlutterLogo extends AnimatedWidget {
  // AnimatedWidget 需要在初始化时传入animation对象，所以构造函数不能少
  AnimatedFadeFlutterLogo({Key key, AnimationController controller})
      : super(key: key, listenable: controller);

  Widget build(BuildContext context) {
    // 取出动画对象
    final AnimationController controller = listenable;
    // 创建线性变化的 Animation 对象
    var animation = Tween(begin: 10.0, end: 100.0).animate(controller);
    //让动画重复执行
    return Center(
      child: FadeTransition(
        opacity: controller,
        child: AnimatedFlutterLogo(animation: animation,),
      ),
    );
  }
}

