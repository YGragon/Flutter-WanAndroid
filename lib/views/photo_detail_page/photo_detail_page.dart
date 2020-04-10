import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/model/constant.dart';
import 'dart:math' as math;

class PhotoDetailPage extends StatefulWidget {
  final String id;
  final String title;
  final String desc;
  final String projectLink;
  final String envelopePic;
  final String niceDate;
  final String author;
  // 主构造函数
  PhotoDetailPage(this.id,this.title, this.desc, this.projectLink, this.envelopePic,
      this.niceDate, this.author);

  @override
  _PhotoDetailPageState createState() => new _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 450,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('${widget.title}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 14),),
              background: Hero(
                tag: '${Constant.heroPhotoDetail} ${widget.id}',
                child: ExtendedImage.network(
                  widget.envelopePic,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        SliverPersistentHeader(
          pinned: false,
          floating: false,
          delegate: _SliverAppBarDelegate(
            minHeight: 60.0,
            maxHeight: 250.0,
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Text('header',style: TextStyle(color: Colors.white),),
              )
            ),
          ),
        ),
          SliverList(
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              //创建列表项
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Text('${widget.desc}',style: TextStyle(height: 2),),
                  SizedBox(
                    height: 50,
                  ),
                  Text('${widget.niceDate}'),
                  SizedBox(
                    height: 50,
                  ),
                  Text('${widget.author}'),
                  SizedBox(
                    height: 50,
                  ),
                ],
              );
            }, childCount: 1 //50个列表项
                ),
          )
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate{
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}