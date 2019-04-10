import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/event/event_bus.dart';
import 'package:flutter_wanandroid/event/event_model.dart';
import 'package:flutter_wanandroid/model/collect.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget{
  final int id;
  final String title;
  final String link;

  WebViewPage(this.id, this.title, this.link);
  _WebViewPageState createState() => _WebViewPageState();

}
class _WebViewPageState extends State<WebViewPage> {

  bool _hasCollected = false;
  String _link = '';
  var _collectionIcons;
  CollectionControlModel _collectionControl = new CollectionControlModel();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _collectionControl
        .getRouterById(widget.id)
        .then((list) {
      list.forEach((item) {
        if (widget.title.trim() == item['title']) {
          _link = item['link'];
        }
      });
      if (mounted) {
        setState(() {
          _hasCollected = list.length > 0;
        });
      }
    });
  }

  // 点击收藏按钮
  _getCollection() {
    if (_hasCollected) {
      // 删除操作
      _collectionControl
          .deleteById(widget.id)
          .then((result) {
        if (result > 0 && this.mounted) {
          setState(() {
            _hasCollected = false;
          });
          print("已取消收藏");

          /// 目前 WebView 插件还没有解决在 WebView 上显示弹窗这个问题 可查看 issue
          /// https://github.com/fluttercommunity/flutter_webview_plugin/issues/69
//          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('已取消收藏')));
          if (ApplicationEvent.event != null) {
            ApplicationEvent.event
                .fire(CollectionEvent(widget.title, _link, true));
          }
          return;
        }
        print('删除错误');
      });
    } else {
      // 插入操作
      _collectionControl
          .insert(Collection(
          id: widget.id.toString(),
          title: widget.title,
          link: widget.link))
          .then((result) {
        if (this.mounted) {
          setState(() {
            _hasCollected = true;
          });
          print("收藏成功");
          /// 目前 WebView 插件还没有解决在 WebView 上显示弹窗这个问题 可查看 issue
          /// https://github.com/fluttercommunity/flutter_webview_plugin/issues/69
//          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('收藏成功')));

          if (ApplicationEvent.event != null) {
            ApplicationEvent.event
                .fire(CollectionEvent(widget.title, _link, false));
          }

        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
      if (_hasCollected) {
        _collectionIcons = Icons.favorite;
      } else {
        _collectionIcons = Icons.favorite_border;
      }
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            new IconButton(
              tooltip: 'goBack home',
              onPressed: _getCollection,
              icon: Icon(
                _collectionIcons,
              ),
            ),
          ],
        ),
        body: WebviewScaffold(
          url: widget.link,
          withZoom: false,
          withLocalStorage: true,
          withJavascript: true,
        ),
      );
    }
}
