import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wanandroid/routers/application.dart';
import 'package:flutter_wanandroid/routers/routes.dart';

/// 瀑布流item
class TileCard extends StatelessWidget {
  final String envelopePic;
  final String title;
  final String desc;
  final String author;
  final String projectLink;
  final String link;
  final String niceDate;

  TileCard(
      {this.envelopePic,
        this.title,
        this.desc,
        this.author,
        this.projectLink,
        this.link,
        this.niceDate});



  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){
          Application.router.navigateTo(context, '${Routes.webViewPage}?id=${Uri.encodeComponent("0")}&title=${Uri.encodeComponent(title)}&link=${Uri.encodeComponent(link)}');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // 图片
            Container(
              color: Colors.deepOrange,
              child: ExtendedImage.network(
                envelopePic,
                fit: BoxFit.fitWidth,
              ),
            ),
            // 描述
            Container(
              padding:
              EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
              margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
              child: Text(
                '$desc',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(40),
                    fontWeight: FontWeight.bold),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
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
                  Container(
                    child: Text(
                      '$author',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(30),
                      ),
                    ),
                  ),
                  // 时间
                  Container(
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(50)),
                    child: Text(
                      '$niceDate',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(30),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}