import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_wanandroid/views/collection_page/collection_page.dart';
import 'package:flutter_wanandroid/views/home_page/home_page.dart';
import 'package:flutter_wanandroid/views/web_page/webview_page.dart';



// app的首页
var homeHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new HomePage();
  },
);

var categoryHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String name = params["type"]?.first;

    return new CollectionPage();
  },
);

//var widgetNotFoundHandler = new Handler(
//    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//      return new WidgetNotFound();
//    });



var webViewPageHand = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String title = params['title']?.first;
      String url = params['url']?.first;
      return new WebViewPage(url, title);
    });
