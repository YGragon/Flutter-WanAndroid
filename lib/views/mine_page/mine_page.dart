import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid/utils/toast.dart';
import 'package:flutter_wanandroid/views/about_page/about_page.dart';
import 'package:flutter_wanandroid/widgets/list_item.dart';
import 'package:url_launcher/url_launcher.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MinePageState();
  }
}

class MinePageState extends State<MinePage> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        EasyRefresh.custom(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                // 顶部栏
                Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 220.0,
                      color: Colors.white,
                    ),
                    ClipPath(
                      clipper: TopBarClipper(
                          MediaQuery.of(context).size.width, 200.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 200.0,
                        child: Container(
                          width: double.infinity,
                          height: 240.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    // 名字
                    Container(
                      margin: EdgeInsets.only(top: 40.0),
                      child: Center(
                        child: Text(
                          '龙衣',
                          style: TextStyle(
                              fontSize: 30.0, color: Colors.white),
                        ),
                      ),
                    ),
                    // 图标
                    Container(
                      margin: EdgeInsets.only(top: 100.0),
                      child: Center(
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            child: PreferredSize(
                              child: Container(
                                child: ClipOval(
                                  child: ExtendedImage.network(
                                    "https://hbimg.huabanimg.com/2955e079403940e85df439dab8baab2dea441c042e0a2-Ndy7fz_fw658",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              preferredSize: Size(80.0, 80.0),
                            ),
                          )),
                    ),
                  ],
                ),
                // 内容
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  child: Card(
                      color: Colors.blue,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            ListItem(
                              icon: Icon(
                                Icons.score,
                                color: Colors.white,
                              ),
                              title: "积分排行榜",
                              titleColor: Colors.white,
                              describeColor: Colors.white,
                              onPressed: () {
                                ToastUtil.showBasicToast("积分排行榜");
                              },
                            ),
                          ],
                        ),
                      )),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  child: Card(
                      color: Colors.deepOrange,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            ListItem(
                              icon: Icon(
                                Icons.info,
                                color: Colors.white,
                              ),
                              title: "关于页面",
                              titleColor: Colors.white,
                              describeColor: Colors.white,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
                              },
                            )
                          ],
                        ),
                      )),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  child: Card(
                      color: Colors.pink,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[

                            ListItem(
                              icon: Icon(
                                Icons.exit_to_app,
                                color: Colors.white,
                              ),
                              title: "退出登录",
                              titleColor: Colors.white,
                              describeColor: Colors.white,
                              onPressed: () {
                                ToastUtil.showBasicToast("退出登录");
                              },
                            )
                          ],
                        ),
                      )),
                ),
              ]),
            ),
          ],
        ),
      ],
    );
  }
}

// 顶部栏裁剪
class TopBarClipper extends CustomClipper<Path> {
  // 宽高
  double width;
  double height;

  TopBarClipper(this.width, this.height);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(width, 0.0);
    path.lineTo(width, height / 2);
    path.lineTo(0.0, height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
