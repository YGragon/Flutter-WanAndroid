/// target: 搜索WidgetDemo中的历史记录model
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utils/shared_preferences.dart';


class SearchHistory {
  final String name;
  final String targetRouter;

  SearchHistory({@required this.name, @required this.targetRouter});
}

class SearchHistoryList {
  static SearchHistoryList _instance;
  static List<SearchHistory> _searchHistoryList = [];

  factory SearchHistoryList() {
    if (_instance == null) {
      print(new ArgumentError(['SearchHistoryList need instantiatied SpUtil at first timte ']));
    }
    return _getInstance();
  }

  static SearchHistoryList _getInstance() {
    if (_instance == null) {
      String json = SPUtils.get(SharedPreferencesKeys.searchHistory);
      print("SearchHistoryList json---->"+json.toString());
      _instance = new SearchHistoryList.fromJSON(json);
    }
    return _instance;
  }


  // 存放的最大数量
  int _count = 10;

  SearchHistoryList.fromJSON(String jsonData) {
    _searchHistoryList = [];
    if (jsonData == null) {
      return;
    }
    List jsonList = json.decode(jsonData);
    jsonList.forEach((value) {
      _searchHistoryList.add(SearchHistory(
          name: value['name'], targetRouter: value['targetRouter']));
    });
  }

  List<SearchHistory> getList() {
    return _searchHistoryList;
  }

  clear() {
    SPUtils.remove(SharedPreferencesKeys.searchHistory);
    _searchHistoryList = [];
  }

  save() {
    SPUtils.putString(SharedPreferencesKeys.searchHistory, this.toJson());
  }

  add(SearchHistory item) {
    print("_searchHistoryList> ${_searchHistoryList.length}");
    for (SearchHistory value in _searchHistoryList) {
      if (value.name == item.name) {
        return;
      }
    }
    if (_searchHistoryList.length > _count) {
      _searchHistoryList.removeAt(0);
    }
    _searchHistoryList.add(item);
    save();
  }

  toJson() {
    List<Map<String, String>> jsonList = [];
    _searchHistoryList.forEach((SearchHistory value) {
      jsonList.add({'name': value.name, 'targetRouter': value.targetRouter});
    });
    return json.encode(jsonList);
  }

  @override
  String toString() {
    return this.toJson();
  }
}
