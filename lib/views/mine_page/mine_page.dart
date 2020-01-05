import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MinePageState();
  }
}

class MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin {
  var userAvatar =
      "https://cn.bing.com/sa/simg/hpb/LaDigue_EN-CA1115245085_1920x1080.jpg";
  var userName = "longyi";

  var titles = [
    "积分排行榜",
    "关于页面",
    "退出登录",
    "广场",
    "发布",
    "测试",
    "测试",
    "测试",
    "测试",
    "测试",
    "测试",
    "测试",
    "测试",
    "测试",
    "测试"
  ];

  @override
  bool get wantKeepAlive => true;

  // Text组件需要用SliverToBoxAdapter包裹，才能作为CustomScrollView的子组件
  Widget renderTitle(String userName) {
    return SliverToBoxAdapter(
      child: Stack(
        children: <Widget>[
          Image.network(userAvatar, fit: BoxFit.cover),
          Center(
            child: GestureDetector(
              onTap: () {
                print("用户信息 or 登录");
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  userAvatar == null
                      ? new Image.asset(
                          "images/ic_avatar_default.png",
                          width: 60.0,
                          height: 60.0,
                        )
                      : new Container(
                          width: 60.0,
                          height: 60.0,
                          margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              image: new DecorationImage(
                                  image: new NetworkImage(userAvatar),
                                  fit: BoxFit.cover),
                              border: new Border.all(
                                  color: Colors.white, width: 2.0)),
                        ),
                  new Container(
                    margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: new Text(
                      userName == null ? '点击头像登录' : userName,
                      style: new TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        reverse: false,
        shrinkWrap: false,
        slivers: <Widget>[
          renderTitle(userName),
          SliverFixedExtentList(
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              String title = titles[index];
              return new Container(
                  alignment: Alignment.centerLeft,
                  child: new InkWell(
                    onTap: () {
                      print("点击了： $title");
                    },
                    child: new Column(
                      children: <Widget>[
                        new Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                          child: new Row(
                            children: <Widget>[
                              new Expanded(
                                  child: new Text(
                                title,
                              )),
                            ],
                          ),
                        ),
                        new Divider(
                          height: 1.0,
                        )
                      ],
                    ),
                  ));
            }, childCount: titles.length),
            itemExtent: 50.0,
          ),
        ]);
  }
}
