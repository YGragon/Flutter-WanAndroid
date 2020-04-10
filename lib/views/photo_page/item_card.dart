import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wanandroid/model/constant.dart';
import 'package:flutter_wanandroid/routers/application.dart';
import 'package:flutter_wanandroid/routers/routes.dart';

/// 瀑布流item
class TileCard extends StatelessWidget with WidgetsBindingObserver {
  final String id;
  final String envelopePic;
  final String title;
  final String desc;
  final String author;
  final String projectLink;
  final String link;
  final String niceDate;

  TileCard(
      {
        this.id,
        this.envelopePic,
        this.title,
        this.desc,
        this.author,
        this.projectLink,
        this.link,
        this.niceDate});


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("TileCard $state");
    if (state == AppLifecycleState.resumed) {
      // do sth
    }
  }

  Widget _buildBottomLayout(BuildContext context,String msg){
    return Container(
      child: Text(
        msg,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){
          // 跳转 WebView
          Application.router.navigateTo(context, '${Routes.webViewPage}?id=${Uri.encodeComponent(id)}&title=${Uri.encodeComponent(title)}&link=${Uri.encodeComponent(link)}');
          // 跳转 Hero 实现的动画效果
//          Application.router.navigateTo(context,
//              '${Routes.photoDetailPage}?id=${Uri.encodeComponent(id)}'
//                  '&title=${Uri.encodeComponent(title)}'
//                  '&desc=${Uri.encodeComponent(desc)}'
//                  '&projectLink=${Uri.encodeComponent(projectLink)}'
//                  '&envelopePic=${Uri.encodeComponent(envelopePic)}'
//                  '&niceDate=${Uri.encodeComponent(niceDate)}'
//                  '&author=${Uri.encodeComponent(author)}');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // 图片
            Container(
              color: Colors.grey,
              child:Hero(
                tag: '${Constant.heroPhotoDetail} $id',
                child:  ExtendedImage.network(
                  envelopePic,
                  fit: BoxFit.fitWidth,
                ),
              )
            ),
            // 描述
            Container(
              margin: EdgeInsets.all(6.0),
              child: Html(data: title,defaultTextStyle: TextStyle(height: 1.50),)
            ),
            // 作者，时间
            Container(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(20),
                  bottom: ScreenUtil().setWidth(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // 作者
                _buildBottomLayout(context,'👲 作者：'+author),
              ],
            )
            )
          ],
        ),
      )
    );
  }
}