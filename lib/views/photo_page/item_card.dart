import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/flutter_html.dart';
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
          Application.router.navigateTo(context, '${Routes.webViewPage}?id=${Uri.encodeComponent("0")}&title=${Uri.encodeComponent(title)}&link=${Uri.encodeComponent(link)}');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // 图片
            Container(
              color: Colors.grey,
              child: ExtendedImage.network(
                envelopePic,
                fit: BoxFit.fitWidth,
              ),
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
                _buildBottomLayout(context,'👲 '+author),
                // 时间
                _buildBottomLayout(context,'🔔'+niceDate),
              ],
            )
            )
          ],
        ),
      )
    );
  }
}