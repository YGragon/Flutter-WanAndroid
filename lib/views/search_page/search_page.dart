import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/api/Api.dart';
import 'package:flutter_wanandroid/api/common_service.dart';
import 'package:flutter_wanandroid/components/search_input.dart';
import 'package:flutter_wanandroid/model/article.dart';
import 'package:flutter_wanandroid/model/search_history.dart';
import 'package:flutter_wanandroid/net/dio_manager.dart';
import 'package:flutter_wanandroid/routers/application.dart';
import 'package:flutter_wanandroid/utils/shared_preferences.dart';

class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage>{
  SpUtil sp;
  SearchHistoryList searchHistoryList;
  bool isSearch = false;

  @override
  void initState() {
    super.initState();

    initSearchHistory();

  }
  /// 初始化搜索历史列表
  initSearchHistory() async {
    sp = await SpUtil.getInstance();
    String json = sp.getString(SharedPreferencesKeys.searchHistory);
    print("json $json");
    searchHistoryList = SearchHistoryList.fromJSON(json);
  }

  ///  搜索列表中的 item 点击
  void onSearchTap(Article article, BuildContext context) {

    searchHistoryList.add(SearchHistory(name: article.title, targetRouter: article.link));
    print("searchHistoryList ${searchHistoryList.toString()}");
    print("点击搜索结果");
//    Application.router.navigateTo(context, "$targetRouter");
  }

  Future<List<Article>> postSearch(String name) async {
    List<Article> items = new List();
    Response response = await DioManager.singleton.dio.post(Api.SEARCH_LIST+"${0}/json?k=$name");
    var articleModel = ArticleModel(response.data);
    items.addAll(articleModel.data.datas);
    return items;
  }


  @override
  Widget build(BuildContext context) {
    return new SearchInput((value)  async{
      if (value != '') {
        // TODO 发起网络请求，搜索结果
        print("----------发起网络请求，搜索结果------>>>>>>>"+value);
        List<Article> articles = await postSearch(value);
        print("----------数据排版---articles--->>>>>>>"+articles.toString());

        return articles.map((item) => new MaterialSearchResult<String>(
          value: item.title,
          icon: Icons.link,
          author: item.author,
          onTap: () {
            // item 点击
            onSearchTap(item, context);
          },
        ))
            .toList();
      } else {
        return null;
      }
    }, (value){},(){});
  }

}