import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/routers/router_path.dart';

import '../../routers/application.dart';
import '../../utils/shared_preferences.dart';

final pages = [
  PageViewModel(
      const Color(0xFFcd344f),
      //'assets/mountain.png',
      'assets/images/p2.png',
      'Flutter-WanAndroid是什么？',
      '仿 阿里前端团队【FlutterGo】 UI 效果的\n【玩Android】项目\nAPI 接口使用的是鸿洋大神的\n【玩Android】接口',
      'assets/images/plane.png'),
  PageViewModel(
      const Color(0xFF638de3),
      //'assets/world.png',
      'assets/images/p1.png',
      'Flutter-WanAndroid 的背景',
      '🐢 学习 Flutter 总结 \n🐞 学习优秀的源码思路\n🐌 实现完整的Flutter项目\n🚀 代码仓库\n',
      'assets/images/calendar.png'),
  PageViewModel(
    const Color(0xFFFF682D),
    //'assets/home.png',
    'assets/images/p3.png',
    'Flutter-WanAndroid 的特点',
    '🐡 UI 效果基本和 Flutter-go 一致\n🐌 增加炫酷的 UI 效果\n🐙 代码简单\n🚀 复制即能使用\n',
    'assets/images/house.png',
  ),
];
SPUtils sp;

class Page extends StatelessWidget {
  final PageViewModel viewModel;
  final double percentVisible;
  Page({
    this.viewModel,
    this.percentVisible = 1.0,
  });

  /// 回到首页
  _goHomePage(context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  /// 回到首页按钮，Github 按钮
  Widget creatButton(
      BuildContext context, String txt, IconData iconName, String type) {
    return RaisedButton.icon(
        onPressed: () async {
          if (type == 'start') {
            SPUtils.putBool(SharedPreferencesKeys.showWelcome, false);
            _goHomePage(context);
          } else if (type == 'goGithub') {
            if(txt == 'Flutter-WanAndroid'){
              Application.router.navigateTo(context,
                  '${RouterPath.webViewPage}?id=${Uri.encodeComponent("0")}&title=${Uri.encodeComponent(txt)}&link=${Uri.encodeComponent("https://github.com/dongxi346/Flutter-WanAndroid")}');
            }else{
              Application.router.navigateTo(context,
                  '${RouterPath.webViewPage}?id=${Uri.encodeComponent("0")}&title=${Uri.encodeComponent(txt)}&link=${Uri.encodeComponent("https://github.com/alibaba/flutter-go")}');
            }
          }
        },
        elevation: 10.0,
        color: Colors.black26,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(20.0))),
        //如果不手动设置icon和text颜色,则默认使用foregroundColor颜色
        icon: Icon(iconName, color: Colors.white, size: 14.0),
        label: Text(
          txt,
          maxLines: 1,
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      //alignment: const Alignment(1.2, 0.6),
        children: [
          Container(
              width: double.infinity,
              /// height:MediaQuery.of(context).size.height-200.0,
              color: viewModel.color,
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Opacity(
                opacity: percentVisible,
                child: ListView(
                  children: <Widget>[
                    layout(context),
                  ],
                ),
              )
          ),
          Positioned(
              right: -5.0,
              top: 2.0,
              child: creatButton(context, 'Flutter-WanAndroid', Icons.arrow_forward, 'goGithub')
          ),
          Positioned(
              right: -5.0,
              top: 50.0,
              child: creatButton(context, 'Flutter-Go', Icons.arrow_forward, 'goGithub')
          ),
        ]
    );
  }

  /// 页面垂直布局
  Column layout(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform(
            transform: Matrix4.translationValues(
                0.0, 50.0 * (1.0 - percentVisible), 0.0),
            child: Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
              /// 顶部图片
              child: Image.asset(viewModel.heroAssetPath,
                  width: 160.0, height: 160.0),
            ),
          ),
          Transform(
            transform: Matrix4.translationValues(
                0.0, 30.0 * (1.0 - percentVisible), 0.0),
            child: Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              /// 标题文字
              child: Text(
                viewModel.title,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'FlamanteRoma',
                  fontSize: 28.0,
                ),
              ),
            ),
          ),
          Transform(
            transform: Matrix4.translationValues(
                0.0, 30.0 * (1.0 - percentVisible), 0.0),
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              /// 描述文字
              child: Text(
                viewModel.body,
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.2,
                  color: Colors.white,
                  fontFamily: 'FlamanteRomaItalic',
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
//          ButtonBar(
//            alignment: MainAxisAlignment.center,
//            children: <Widget>[
//              creatButton(context, '开始使用', Icons.add_circle_outline, 'start'),
//              creatButton(context, 'GitHub', Icons.arrow_forward, 'goGithub'),
//            ],
//          )
        ]);
  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String iconAssetPath;

  PageViewModel(
      this.color,
      this.heroAssetPath,
      this.title,
      this.body,
      this.iconAssetPath,
      );
}
