
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wanandroid/components/search_input.dart';
import 'package:flutter_wanandroid/routers/application.dart';
import 'package:flutter_wanandroid/utils/provider.dart';
import 'package:flutter_wanandroid/utils/shared_preferences.dart';
import 'package:flutter_wanandroid/views/cat_page/cat_page.dart';
import 'package:flutter_wanandroid/views/collection_page/collection_page.dart';
import 'package:flutter_wanandroid/views/home_page/home_page.dart';
import 'package:flutter_wanandroid/views/mine_page/mine_page.dart';
import 'package:flutter_wanandroid/views/photo_page/photo_page.dart';

import 'package:flutter_wanandroid/model/search_history.dart';


const int ThemeColor = 0xFFC91B3A;

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MainPage> with SingleTickerProviderStateMixin {

  SpUtil sp;

  TabController controller;
  SearchHistoryList searchHistoryList;

  String data = '无';
  String appBarTitle = tabData[0]['text'];
  static List tabData = [
    {'text': '首页', 'icon': new Icon(Icons.home)},
    {'text': '猫耳', 'icon': new Icon(Icons.category)},
    {'text': '收藏', 'icon': new Icon(Icons.favorite)},
    {'text': '图库', 'icon': new Icon(Icons.photo)},
    {'text': '我的', 'icon': new Icon(Icons.person)}
  ];

  List<Widget> myTabs = [];

  @override
  void initState() {
    super.initState();

    initSearchHistory();
    controller = new TabController(
        initialIndex: 0, vsync: this, length: 5); // 这里的length 决定有多少个底导 submenus
    for (int i = 0; i < tabData.length; i++) {
      myTabs.add(new Tab(text: tabData[i]['text'], icon: tabData[i]['icon']));
    }

    /// 滑动监听
    controller.addListener(() {
      if (controller.indexIsChanging) {
        _onTabChange();
      }
    });
    Application.controller = controller;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// 初始化搜索历史列表
  initSearchHistory() async {
    sp = await SpUtil.getInstance();
    String json = sp.getString(SharedPreferencesKeys.searchHistory);
    print("json----------------->>>>> $json");
    searchHistoryList = SearchHistoryList.fromJSON(json);
  }

//  ///  搜索列表中的 item 点击
//  void onWidgetTap(WidgetPoint widgetPoint, BuildContext context) {
//    List widgetDemosList = new WidgetDemoList().getDemos();
//    String targetName = widgetPoint.name;
//    String targetRouter = '/category/error/404';
//    widgetDemosList.forEach((item) {
//      if (item.name == targetName) {
//        targetRouter = item.routerName;
//      }
//    });
//    searchHistoryList.add(SearchHistory(name: targetName, targetRouter: targetRouter));
//    print("searchHistoryList ${searchHistoryList.toString()}");
//    Application.router.navigateTo(context, "$targetRouter");
//  }
//
//  /// 联想搜索，显示搜索结果列表
//  Widget buildSearchInput(BuildContext context) {
//    return new SearchInput((value) async {
//      if (value != '') {
////        List<WidgetPoint> list = await widgetControl.search(value);
//
//        return list
//            .map((item) => new MaterialSearchResult<String>(
//          value: item.name,
//          icon: Icons.link,
//          text: item.author,
//          onTap: () {
//            // item 点击
//            onWidgetTap(item, context);
//          },
//        ))
//            .toList();
//      } else {
//        return null;
//      }
//    }, (value) {}, () {});
//  }


  @override
  Widget build(BuildContext context) {
    var db = Provider.db;
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 此处假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    //ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    ScreenUtil.init(context);

    return new Scaffold(
      body: new TabBarView(controller: controller, children: <Widget>[
        new HomePage(),
        new CatPage(),
        new CollectionPage(),
        new PhotoPage(),
        new MinePage(),
      ]),
      bottomNavigationBar: Material(
        color: const Color(0xFFF0EEEF), //底部导航栏主题颜色
        child: SafeArea(
          child: Container(
            height: 65.0,
            /// 渐变效果
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0xFFd0d0d0),
                  blurRadius: 3.0,
                  spreadRadius: 2.0,
                  offset: Offset(-1.0, -1.0),
                ),
              ],
            ),
            child: TabBar(
                controller: controller,
                indicatorColor: Theme.of(context).primaryColor,
                //tab标签的下划线颜色
                // labelColor: const Color(0xFF000000),
                indicatorWeight: 3.0,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: const Color(0xFF8E8E8E),
                tabs: myTabs),
          ),
        ),
      ),
    );

  }

  /// 底部tab点击
  void _onTabChange() {
    if (this.mounted) {
      this.setState(() {
        appBarTitle = tabData[controller.index]['text'];
      });
    }
  }
}
