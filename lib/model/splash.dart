/// 每日一图
class Splash {
  List<Images> images;
  Tooltips tooltips;

  Splash({this.images, this.tooltips});

  Splash.fromJson(Map<String, dynamic> json) {
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    tooltips = json['tooltips'] != null
        ? new Tooltips.fromJson(json['tooltips'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.tooltips != null) {
      data['tooltips'] = this.tooltips.toJson();
    }
    return data;
  }
}

class Images {
  String startdate;
  String fullstartdate;
  String enddate;
  String url;
  String urlbase;
  String copyright;
  String copyrightlink;
  String title;
  String quiz;
  bool wp;
  String hsh;
  int drk;
  int top;
  int bot;
  List<Null> hs;

  Images(
      {this.startdate,
        this.fullstartdate,
        this.enddate,
        this.url,
        this.urlbase,
        this.copyright,
        this.copyrightlink,
        this.title,
        this.quiz,
        this.wp,
        this.hsh,
        this.drk,
        this.top,
        this.bot,
        this.hs});

  Images.fromJson(Map<String, dynamic> json) {
    startdate = json['startdate'];
    fullstartdate = json['fullstartdate'];
    enddate = json['enddate'];
    url = json['url'];
    urlbase = json['urlbase'];
    copyright = json['copyright'];
    copyrightlink = json['copyrightlink'];
    title = json['title'];
    quiz = json['quiz'];
    wp = json['wp'];
    hsh = json['hsh'];
    drk = json['drk'];
    top = json['top'];
    bot = json['bot'];
    if (json['hs'] != null) {
      hs = new List<Null>();
//      json['hs'].forEach((v) {
//        hs.add(new Null.fromJson(v));
//      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startdate'] = this.startdate;
    data['fullstartdate'] = this.fullstartdate;
    data['enddate'] = this.enddate;
    data['url'] = this.url;
    data['urlbase'] = this.urlbase;
    data['copyright'] = this.copyright;
    data['copyrightlink'] = this.copyrightlink;
    data['title'] = this.title;
    data['quiz'] = this.quiz;
    data['wp'] = this.wp;
    data['hsh'] = this.hsh;
    data['drk'] = this.drk;
    data['top'] = this.top;
    data['bot'] = this.bot;
    if (this.hs != null) {
//      data['hs'] = this.hs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tooltips {
  String loading;
  String previous;
  String next;
  String walle;
  String walls;

  Tooltips({this.loading, this.previous, this.next, this.walle, this.walls});

  Tooltips.fromJson(Map<String, dynamic> json) {
    loading = json['loading'];
    previous = json['previous'];
    next = json['next'];
    walle = json['walle'];
    walls = json['walls'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loading'] = this.loading;
    data['previous'] = this.previous;
    data['next'] = this.next;
    data['walle'] = this.walle;
    data['walls'] = this.walls;
    return data;
  }
}
