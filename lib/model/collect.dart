import 'dart:async';

import 'package:flutter_wanandroid/utils/sql.dart';


abstract class CollectionInterface {
  String get id;
  String get title;
  String get link;
}

class Collection implements CollectionInterface {
  String id;
  String title;
  String link;

  Collection({this.id, this.title, this.link});

  factory Collection.fromJSON(Map json){
    return Collection(id: json['id'],title: json['title'],link: json['link']);
  }

  Object toMap() {
    return {'id': id, 'title': title, 'link':link};
  }

}

class CollectionControlModel {
  final String table = 'collection';
  Sql sql;

  CollectionControlModel() {
    sql = Sql.setTable(table);
  }

  // 获取所有的收藏

  // 插入新收藏
  Future insert(Collection collection) {
    var result =
    sql.insert({'id': collection.id, 'title': collection.title, 'link':collection.link});
    return result;
  }

  // 获取全部的收藏
  Future<List<Collection>> getAllCollection() async {
    List list = await sql.getByCondition();
    List<Collection> resultList = [];
    list.forEach((item){
      print(item);
      resultList.add(Collection.fromJSON(item));
    });
    return resultList;
  }

  // 通过 ID 获取router
  Future getRouterById(int id) async {
    List list = await sql.getByCondition(conditions: {'id': id});
    return list;
  }

  // 删除
  Future deleteById(int id) async{
    return await sql.delete(id.toString(),'id');
  }
}
