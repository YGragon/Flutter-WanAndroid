import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/api/Api.dart';
import 'package:flutter_wanandroid/api/common_service.dart';
import 'package:flutter_wanandroid/components/home_banner.dart';
import 'package:flutter_wanandroid/model/banner.dart';
import 'package:url_launcher/url_launcher.dart';


// Banner
class Pagination extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BannerState();
  }
}

class BannerState extends State<Pagination> {
  List<BannerData> _bannerList  = new List();

  @override
  void initState() {
    _getBanner();
  }

  Future<Null> _getBanner() async{
    _bannerList.clear();
    CommonService().getBanner((BannerModel _bean) {
      if (_bean.data.length > 0) {
        if(mounted){
          setState(() {
            _bannerList = _bean.data;
          });
        }
      }
    });
  }


  /// 打开本地浏览器
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
        key:Key('__header__'),
        //physics: AlwaysScrollableScrollPhysics(),
        //padding: EdgeInsets.only(),
        children: _pageSelector(context)
    );
  }

  List<Widget> _pageSelector(BuildContext context) {
    List<Widget> list = [];
    if (_bannerList.length > 0) {
      list.add(HomeBanner(_bannerList, (story) {
        _launchURL('${story.url}');
      }));
    }
    return list;
  }
}
