import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



// ValueKey<String> key;

class HomePage extends StatefulWidget {
  @override
  FirstPageState createState() => new FirstPageState();
}

class FirstPageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> _unKnow;
//  GlobalKey<DisclaimerMsgState> key;

  @override
  bool get wantKeepAlive => true;





  /// banner
  headerView(){
    return
      Column(
        children: <Widget>[
          SizedBox(height: 1, child:Container(color: Theme.of(context).primaryColor)),
          SizedBox(height: 10),
        ],
      );

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Column(
        children: <Widget>[
//          new Stack(
//            //alignment: const FractionalOffset(0.9, 0.1),//方法一
//            children: <Widget>[
//            Pagination(),
//            Positioned(//方法二
//              top: 10.0,
//              left: 0.0,
//              child: DisclaimerMsg(key:key,pWidget:this)
//            ),
//          ]),
//          SizedBox(height: 2, child:Container(color: Theme.of(context).primaryColor)),
          new Expanded(
            //child: new List(),
            child: new Text("首页额内容"),
//              child: listComp.ListRefresh(getIndexListData,makeCard,headerView)
          )
        ]

    );
  }
}


