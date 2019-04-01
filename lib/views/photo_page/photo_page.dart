import 'package:flutter/cupertino.dart';

class PhotoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new PhotoPageState();
  }

}

class PhotoPageState extends State<PhotoPage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text("图库页面"),
    );
  }

}