import 'package:flutter/cupertino.dart';

class MinePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new MinePageState();
  }

}

class MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text("我的页面"),
    );
  }
}