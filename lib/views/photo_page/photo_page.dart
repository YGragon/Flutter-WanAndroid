import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_wanandroid/components/search_input.dart';


class PhotoPage extends StatelessWidget {


  /// TODO 抽取出去 联想搜索，显示搜索结果列表
  Widget buildSearchInput(BuildContext context){
    return new SearchInput((value)  async{
      if (value != '') {
        // TODO 发起网络请求，搜索结果
        print("---------------->>>>>>>"+value);
      } else {
        return null;
      }
    }, (value){},(){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: buildSearchInput(context),),
      body: new Center(
        child: new Text("图片中心"),
      ));
  }

}