
import 'dart:convert' show json;

import 'package:flutter_wanandroid/model/article.dart';

class CatModel{

  int errorCode;
  String errorMsg;
  List<Cat> data;

  CatModel.fromParams({this.errorCode, this.errorMsg, this.data});
  factory CatModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new CatModel.fromJson(json.decode(jsonStr)) : new CatModel.fromJson(jsonStr);

  CatModel.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    data = jsonRes['data'] == null ? null :[];

    /// 项目和体系的集合
    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : new Cat.fromJson(dataItem));
    }

  }
  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null?'${json.encode(errorMsg)}':'null'},"data": $data}';
  }
}

class Cat {

  int id;
  /// 导航的 id
  int cid;
  int superChapterId;
  int parentChapterId;
  int order;
  String name;
  String title;
  String link;
  List<Cat> cats;
  List<Article> articles;


  Cat.fromParams({this.id, this.superChapterId, this.parentChapterId, this.order, this.name, this.title, this.link});
  Cat.fromJson(jsonRes) {
    superChapterId = jsonRes['superChapterId'] == null ? -1 : jsonRes['superChapterId'];
    parentChapterId = jsonRes['parentChapterId'] == null ? -1 : jsonRes['parentChapterId'];
    order = jsonRes['order'];
    id = jsonRes['id'];
    cid = jsonRes['cid'] == null ? -1 : jsonRes['cid'];
    name = jsonRes['name'] == null ? null : jsonRes['name'];
    link = jsonRes['link'] == null ? null : jsonRes['link'];
    title = jsonRes['title'] == null ? null : jsonRes['title'];
    cats = jsonRes['children'] == null ? null :[];
    articles = jsonRes['data'] == null ? null :[];


    /// 获取项目、体系下的集合
    for (var dataItem in cats == null ? [] : jsonRes['children']){
      cats.add(dataItem == null ? null : new Cat.fromJson(dataItem));
    }

    /// 导航的信息
    for (var dataItem in articles == null ? [] : jsonRes['articles']){
      articles.add(dataItem == null ? null : new Article.fromJson(dataItem));
    }
  }

  String toString() {
    return '{"superChapterId": $superChapterId,"parentChapterId": $parentChapterId,"order": $order,'
        '"id": $id,"link": ${link != null?'${json.encode(link)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},'
        '"name": ${name != null?'${json.encode(name)}':'null'},"cats": $cats,"articles": $articles}';
  }
}
