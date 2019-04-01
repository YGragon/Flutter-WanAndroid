import 'package:flutter/cupertino.dart';

class CollectionPage extends StatefulWidget{
  @override
  CollectionPageState  createState() => new CollectionPageState();
}

class CollectionPageState extends State<CollectionPage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text("收藏页面"),
    );
  }

}