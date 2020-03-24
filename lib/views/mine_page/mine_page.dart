import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid/api/common_service.dart';
import 'package:flutter_wanandroid/model/user.dart';
import 'package:flutter_wanandroid/model/user_model.dart';
import 'package:flutter_wanandroid/utils/image.dart';
import 'package:flutter_wanandroid/utils/shared_preferences.dart';
import 'package:flutter_wanandroid/utils/toast.dart';
import 'package:flutter_wanandroid/views/about_page/about_page.dart';
import 'package:flutter_wanandroid/views/login_page/login_page.dart';
import 'package:flutter_wanandroid/views/login_page/login_page_test.dart';
import 'package:flutter_wanandroid/views/my_collect_list_page/my_collect_list_page.dart';
import 'package:flutter_wanandroid/widgets/list_item.dart';
import 'package:url_launcher/url_launcher.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    print("minePage-createState");
    return new MinePageState();
  }
}

class MinePageState extends State<MinePage> with WidgetsBindingObserver {
  MinePageState(){
    print("minePage-constructor");
  }

  String _userName = "未登录";
  String _getUserName(){
    if(mounted){

      User().getUserInfo().then((username){
        if (username != null && username.isNotEmpty) {
          User().setLogin(true);
          setState(() {
            _userName = username;
          });
        } else {
          User().setLogin(false);
          setState(() {
            _userName = "未登录";
          });
        }
      });
    }
  }

  @override
  void initState() {
    _getUserName();
    super.initState();
    print("minePage-initState");
    WidgetsBinding.instance.addObserver(this);//注册监听器

//    WidgetsBinding.instance.addPostFrameCallback((_){
//      print("单次Frame绘制回调");//只回调一次
//    });
//
//
//    WidgetsBinding.instance.addPersistentFrameCallback((_){
//      print("实时Frame绘制回调");//每帧都回调
//    });
  }

  @override
  void deactivate() {
    super.deactivate();
    print("minePage-deactivate");
    var bool = ModalRoute.of(context).isCurrent;
    print("页面返回："+bool.toString());
    if (bool) {
      _getUserName();
    }
  }

  @override
  void dispose() {
    super.dispose();
    print("minePage-deactivate");
    WidgetsBinding.instance.removeObserver(this);//移除监听器
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("minePage-didChangeDependencies");
  }

  @override
  void didUpdateWidget(MinePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("minePage-didUpdateWidget");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("$state");
    if (state == AppLifecycleState.resumed) {
      // do sth
    }
  }

  @override
  Widget build(BuildContext context) {
    print("minePage-build");
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
                      child: new InkWell(
                        onTap: () {
                          if(User().isUserLogin()){
                            print("显示用户信息");
                          }else{
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new LoginPage()));
                          }

                        },
                        child: Center(
                            child: Text(
                              _userName,
                              style: TextStyle(fontSize: 30.0, color: Colors.white),
                        )),
                      ),
                    ),
                    // 头像
                    Container(
                      margin: EdgeInsets.only(top: 100.0),
                      child:  Center(
                          child: Container(
                              width: 100.0,
                              height: 100.0,
                              child: ClipOval(
                                  child: ExtendedImage.network(
                                    "https://hbimg.huabanimg.com/2955e079403940e85df439dab8baab2dea441c042e0a2-Ndy7fz_fw658",
                                    fit: BoxFit.fill,
                                  )
                              )
                          )
                      )
                    ),
                  ],
                ),
                // 内容
                _buildItem(context, Colors.blue,Icons.favorite,"我的收藏",(){
                  if(User().isUserLogin()){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyCollectListPage()));
                  }else{
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()));
                  }

                }),
                _buildItem(context, Colors.deepOrange,Icons.info,"关于页面",(){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AboutPage()));
                }),
                _buildItem(context, Colors.pink,Icons.exit_to_app,"退出登录",(){
                  _logout();
                })
              ]),
            ),
          ],
        ),
      ],
    );
  }

  /// 退出登录
  void _logout() {
    CommonService().logout((UserModel _userModel) {
      if (_userModel.errorCode == 0) {
        ToastUtil.showBasicToast("您已退出登录");
        /// 删除本地缓存
       User().clearUserInfor();
        _getUserName();
      } else if (_userModel.errorCode == -1) {
        ToastUtil.showBasicToast(_userModel.errorMsg);
      }
    });
  }
}

Widget _buildItem(BuildContext context,Color color, IconData icons, String title, [Function callback]){

  return Container(
    width: double.infinity,
    color: Colors.white,
    padding: EdgeInsets.all(10.0),
    child: Card(
        color: color,
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              ListItem(
                icon: Icon(
                  icons,
                  color: Colors.white,
                ),
                title: title,
                titleColor: Colors.white,
                describeColor: Colors.white,
                onPressed: () {
                  callback();
                },
              )
            ],
          ),
        )),
  );
}

// 顶部栏裁剪
class TopBarClipper extends CustomClipper<Path> {
  // 宽高
  double width;
  double height;

  TopBarClipper(this.width, this.height);

  /// 获取剪裁区域的接口
  /// 返回斜对角的图形 path
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(width, 0.0);
    path.lineTo(width, height / 2);
    path.lineTo(0.0, height);
    return path;
  }
  /// 接口决定是否重新剪裁
  /// 如果在应用中，剪裁区域始终不会发生变化时应该返回 false，这样就不会触发重新剪裁，避免不必要的性能开销。
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
