class Coin {
  String errorMsg;
  int errorCode;
  DataBean data;

  Coin({this.errorMsg, this.errorCode, this.data});

  Coin.fromJson(Map<String, dynamic> json) {
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
  List<CoinInfo> datas;

  DataBean({this.over, this.curPage, this.offset, this.pageCount, this.size, this.total, this.datas});

  DataBean.fromJson(Map<String, dynamic> json) {
    this.over = json['over'];
    this.curPage = json['curPage'];
    this.offset = json['offset'];
    this.pageCount = json['pageCount'];
    this.size = json['size'];
    this.total = json['total'];
    this.datas = (json['datas'] as List)!=null?(json['datas'] as List).map((i) => CoinInfo.fromJson(i)).toList():null;
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

class CoinInfo {
  String username;
  int coinCount;
  int level;
  String rank;
  int userId;

  CoinInfo({this.username, this.coinCount, this.level, this.rank, this.userId});

  CoinInfo.fromJson(Map<String, dynamic> json) {
    this.username = json['username'];
    this.coinCount = json['coinCount'];
    this.level = json['level'];
    this.rank = json['rank'];
    this.userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['coinCount'] = this.coinCount;
    data['level'] = this.level;
    data['rank'] = this.rank;
    data['userId'] = this.userId;
    return data;
  }
}
