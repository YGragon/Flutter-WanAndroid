import 'dart:convert' show json;

class NaviBeanModel {

  int errorCode;
  String errorMsg;
  List<NaviData> datas;

  NaviBeanModel.fromParams({this.errorCode, this.errorMsg, this.datas});

  factory NaviBeanModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new NaviBeanModel.fromJson(json.decode(jsonStr)) : new NaviBeanModel.fromJson(jsonStr);

  NaviBeanModel.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    datas = jsonRes['data'] == null ? null : [];

    for (var datasItem in datas == null ? [] : jsonRes['data']){
      datas.add(datasItem == null ? null : new NaviData.fromJson(datasItem));
    }
  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null?'${json.encode(errorMsg)}':'null'},"data": $datas}';
  }
}

class NaviData {

  int cid;
  String name;
  List<NaviArticle> articles;

  NaviData.fromParams({this.cid, this.name, this.articles});

  NaviData.fromJson(jsonRes) {
    cid = jsonRes['cid'];
    name = jsonRes['name'];
    articles = jsonRes['articles'] == null ? null : [];

    for (var datasItem in articles == null ? [] : jsonRes['articles']){
      articles.add(datasItem == null ? null : new NaviArticle.fromJson(datasItem));
    }
  }

  @override
  String toString() {
    return '{"cid": $cid,"name": $name,"articles": $articles}';
  }
}

class NaviArticle {

  String apkLink;
  int audit;
  String author;
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  String desc;
  String envelopePic;
  bool fresh;
  int id;
  String link;
  String niceDate;
  String niceShareDate;
  String origin;
  String prefix;
  String projectLink;
  int selfVisible;
  int publishTime;
  int shareDate;
  String shareUser;
  int superChapterId;
  String superChapterName;
  List<Tag> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  NaviArticle.fromParams({this.chapterId, this.audit, this.prefix, this.selfVisible, this.courseId, this.id,
    this.publishTime, this.superChapterId, this.type, this.userId, this.visible, this.zan,
    this.collect, this.fresh, this.apkLink, this.author, this.chapterName, this.desc,
    this.envelopePic, this.link, this.niceDate,this.niceShareDate, this.origin, this.projectLink, this.superChapterName,
    this.title, this.shareUser, this.shareDate, this.tags});

  NaviArticle.fromJson(jsonRes) {
    chapterId = jsonRes['chapterId'];
    courseId = jsonRes['courseId'];
    id = jsonRes['id'];
    audit = jsonRes['audit'];
    selfVisible = jsonRes['selfVisible'];
    publishTime = jsonRes['publishTime'];
    superChapterId = jsonRes['superChapterId'];
    type = jsonRes['type'];
    prefix = jsonRes['prefix'];
    userId = jsonRes['userId'];
    visible = jsonRes['visible'];
    zan = jsonRes['zan'];
    collect = jsonRes['collect'];
    fresh = jsonRes['fresh'];
    apkLink = jsonRes['apkLink'];
    author = jsonRes['author'];
    chapterName = jsonRes['chapterName'];
    desc = jsonRes['desc'];
    envelopePic = jsonRes['envelopePic'];
    link = jsonRes['link'];
    niceDate = jsonRes['niceDate'];
    niceShareDate = jsonRes['niceShareDate'];
    origin = jsonRes['origin'];
    projectLink = jsonRes['projectLink'];
    superChapterName = jsonRes['superChapterName'];
    title = jsonRes['title'];
    shareUser = jsonRes['shareUser'];
    shareDate = jsonRes['shareDate'];
    tags = jsonRes['tags'] == null ? null : [];

    for (var tagsItem in tags == null ? [] : jsonRes['tags']){
      tags.add(tagsItem == null ? null : new Tag.fromJson(tagsItem));
    }
  }

  @override
  String toString() {
    return '{"chapterId": $chapterId,"courseId": $courseId,,"prefix": $prefix,,"selfVisible": $selfVisible,"id": $id,"publishTime": $publishTime,"superChapterId": $superChapterId,"type": $type,"userId": $userId,'
        '"visible": $visible,"zan": $zan,"collect": $collect,"fresh": $fresh,"apkLink": ${apkLink != null?'${json.encode(apkLink)}':'null'},'
        '"author": ${author != null?'${json.encode(author)}':'null'},"chapterName": ${chapterName != null?'${json.encode(chapterName)}':'null'},"desc": ${desc != null?'${json.encode(desc)}':'null'},'
        '"envelopePic": ${envelopePic != null?'${json.encode(envelopePic)}':'null'},"link": ${link != null?'${json.encode(link)}':'null'},"niceDate": ${niceDate != null?'${json.encode(niceDate)}':'null'},'
        '"origin": ${origin != null?'${json.encode(origin)}':'null'},"projectLink": ${projectLink != null?'${json.encode(projectLink)}':'null'},'
        '"superChapterName": ${superChapterName != null?'${json.encode(superChapterName)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},'
        '"shareUser": ${shareUser != null?'${json.encode(shareUser)}':'null'},"shareDate": $shareDate,"niceShareDate": $niceShareDate,"tags": $tags}';
  }
}

class Tag {

  String name;
  String url;

  Tag.fromParams({this.name, this.url});

  Tag.fromJson(jsonRes) {
    name = jsonRes['name'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"name": ${name != null?'${json.encode(name)}':'null'},"url": ${url != null?'${json.encode(url)}':'null'}}';
  }
}

