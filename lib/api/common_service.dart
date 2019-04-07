import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/api/Api.dart';
import 'package:flutter_wanandroid/model/article.dart';
import 'package:flutter_wanandroid/model/banner.dart';
import 'package:flutter_wanandroid/model/user.dart';
import 'package:flutter_wanandroid/net/dio_manager.dart';

class CommonService{

  Options _getOptions() {
    Map<String,String> map = new Map();
    List<String> cookies = User().cookie;
    map["Cookie"] = cookies.toString();
    return Options(headers: map);
  }

  void getBanner(Function callback) async {
    DioManager.singleton.dio.get(Api.HOME_BANNER, options: _getOptions()).then((response) {
      callback(BannerModel(response.data));
    });
  }
  void getArticleList(Function callback,int _page) async {
    print("url: "+Api.HOME_ARTICLE_LIST+"$_page/json");
    DioManager.singleton.dio.get(Api.HOME_ARTICLE_LIST+"$_page/json", options: _getOptions()).then((response) {
      callback(ArticleModel(response.data));
    });
  }
}