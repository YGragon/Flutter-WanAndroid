import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/event/event_bus.dart';
import 'package:flutter_wanandroid/event/event_model.dart';
import 'package:flutter_wanandroid/model/collect.dart';
import 'package:flutter_wanandroid/routers/application.dart';
import 'package:flutter_wanandroid/routers/routes.dart';

class CollectionPage extends StatefulWidget{
  @override
  CollectionPageState  createState() => new CollectionPageState();
}

class CollectionPageState extends State<CollectionPage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  CollectionPageState() {
    final eventBus = new EventBus();
    ApplicationEvent.event = eventBus;
  }
  CollectionControlModel _collectionControl = new CollectionControlModel();
  List<Collection> _collectionList = [];
  ScrollController _scrollController = new ScrollController();
  var _icons;

  @override
  void initState() {
    super.initState();
    _getList();
    ApplicationEvent.event.on<CollectionEvent>().listen((event) {
      _getList();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _getList() {
    _collectionList.clear();
    _collectionControl.getAllCollection().then((resultList) {
      resultList.forEach((item) {
        _collectionList.add(item);
      });
      if (this.mounted) {
        setState(() {
          _collectionList = _collectionList;
        });
      }
    });
  }

  Widget _renderList(context, index) {
    if (index == 0) {
      return Container(
        height: 40.0,
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.warning,
              size: 22.0,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text('模拟器重新运行会丢失收藏'),
          ],
        ),
      );
    }
    _icons = Icons.language;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      margin: const EdgeInsets.only(bottom: 7.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            color: const Color(0xFFd0d0d0),
            blurRadius: 1.0,
            spreadRadius: 2.0,
            offset: Offset(3.0, 2.0),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          _icons,
          size: 30.0,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          _collectionList[index - 1].title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 17.0),
        ),
        trailing:
        Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 30.0),
        onTap: () {
            // 需要转义 Uri.encodeComponent
          var collection = _collectionList[index - 1];
            Application.router.navigateTo(context,
                '${Routes.webViewPage}?id=${Uri.encodeComponent(collection.id)}&title=${Uri.encodeComponent(collection.title)}&link=${Uri.encodeComponent(collection.link)}');

        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_collectionList.length == 0) {
      return ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Image.asset(
                'assets/images/nothing.png',
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width / 2,
              ),
              Text('暂无收藏，赶紧去收藏一个吧!'),
            ],
          ),
        ],
      );
    }
    return ListView.builder(
      itemBuilder: _renderList,
      itemCount: _collectionList.length + 1,
      controller: _scrollController,
    );
  }

}