class ProjectModel {
  String errorMsg;
  int errorCode;
  DataBean data;

  ProjectModel({this.errorMsg, this.errorCode, this.data});


  ProjectModel.fromJson(Map<String, dynamic> json) {    
    this.errorMsg = json['errorMsg'];
    this.errorCode = json['errorCode'];
    this.data = json['data'] != null ? DataBean.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorMsg'] = this.errorMsg;
    data['errorCode'] = this.errorCode;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }

}

class DataBean {
  bool over;
  int curPage;
  int offset;
  int pageCount;
  int size;
  int total;
  List<DatasListBean> datas;

  DataBean({this.over, this.curPage, this.offset, this.pageCount, this.size, this.total, this.datas});

  DataBean.fromJson(Map<String, dynamic> json) {    
    this.over = json['over'];
    this.curPage = json['curPage'];
    this.offset = json['offset'];
    this.pageCount = json['pageCount'];
    this.size = json['size'];
    this.total = json['total'];
    this.datas = (json['datas'] as List)!=null?(json['datas'] as List).map((i) => DatasListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['over'] = this.over;
    data['curPage'] = this.curPage;
    data['offset'] = this.offset;
    data['pageCount'] = this.pageCount;
    data['size'] = this.size;
    data['total'] = this.total;
    data['datas'] = this.datas != null?this.datas.map((i) => i.toJson()).toList():null;
    return data;
  }
}

class DatasListBean {
  String apkLink;
  String author;
  String chapterName;
  String desc;
  String descMd;
  String envelopePic;
  String link;
  String niceDate;
  String niceShareDate;
  String origin;
  String prefix;
  String projectLink;
  String shareUser;
  String superChapterName;
  String title;
  bool canEdit;
  bool collect;
  bool fresh;
  int audit;
  int chapterId;
  int courseId;
  int id;
  int selfVisible;
  int superChapterId;
  int type;
  int userId;
  int visible;
  int zan;
  num publishTime;
  num shareDate;
  List<TagsListBean> tags;

  DatasListBean({this.apkLink, this.author, this.chapterName, this.desc, this.descMd, this.envelopePic, this.link, this.niceDate, this.niceShareDate, this.origin, this.prefix, this.projectLink, this.shareUser, this.superChapterName, this.title, this.canEdit, this.collect, this.fresh, this.audit, this.chapterId, this.courseId, this.id, this.selfVisible, this.superChapterId, this.type, this.userId, this.visible, this.zan, this.publishTime, this.shareDate, this.tags});

  DatasListBean.fromJson(Map<String, dynamic> json) {    
    this.apkLink = json['apkLink'];
    this.author = json['author'];
    this.chapterName = json['chapterName'];
    this.desc = json['desc'];
    this.descMd = json['descMd'];
    this.envelopePic = json['envelopePic'];
    this.link = json['link'];
    this.niceDate = json['niceDate'];
    this.niceShareDate = json['niceShareDate'];
    this.origin = json['origin'];
    this.prefix = json['prefix'];
    this.projectLink = json['projectLink'];
    this.shareUser = json['shareUser'];
    this.superChapterName = json['superChapterName'];
    this.title = json['title'];
    this.canEdit = json['canEdit'];
    this.collect = json['collect'];
    this.fresh = json['fresh'];
    this.audit = json['audit'];
    this.chapterId = json['chapterId'];
    this.courseId = json['courseId'];
    this.id = json['id'];
    this.selfVisible = json['selfVisible'];
    this.superChapterId = json['superChapterId'];
    this.type = json['type'];
    this.userId = json['userId'];
    this.visible = json['visible'];
    this.zan = json['zan'];
    this.publishTime = json['publishTime'];
    this.shareDate = json['shareDate'];
    this.tags = (json['tags'] as List)!=null?(json['tags'] as List).map((i) => TagsListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apkLink'] = this.apkLink;
    data['author'] = this.author;
    data['chapterName'] = this.chapterName;
    data['desc'] = this.desc;
    data['descMd'] = this.descMd;
    data['envelopePic'] = this.envelopePic;
    data['link'] = this.link;
    data['niceDate'] = this.niceDate;
    data['niceShareDate'] = this.niceShareDate;
    data['origin'] = this.origin;
    data['prefix'] = this.prefix;
    data['projectLink'] = this.projectLink;
    data['shareUser'] = this.shareUser;
    data['superChapterName'] = this.superChapterName;
    data['title'] = this.title;
    data['canEdit'] = this.canEdit;
    data['collect'] = this.collect;
    data['fresh'] = this.fresh;
    data['audit'] = this.audit;
    data['chapterId'] = this.chapterId;
    data['courseId'] = this.courseId;
    data['id'] = this.id;
    data['selfVisible'] = this.selfVisible;
    data['superChapterId'] = this.superChapterId;
    data['type'] = this.type;
    data['userId'] = this.userId;
    data['visible'] = this.visible;
    data['zan'] = this.zan;
    data['publishTime'] = this.publishTime;
    data['shareDate'] = this.shareDate;
    data['tags'] = this.tags != null?this.tags.map((i) => i.toJson()).toList():null;
    return data;
  }
}

class TagsListBean {
  String name;
  String url;

  TagsListBean({this.name, this.url});

  TagsListBean.fromJson(Map<String, dynamic> json) {    
    this.name = json['name'];
    this.url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
