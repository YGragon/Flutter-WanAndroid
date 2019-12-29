import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/api/common_service.dart';
import 'package:flutter_wanandroid/components/cate_card_container.dart';
import 'package:flutter_wanandroid/model/car.dart';

class CateCard extends StatefulWidget {
  // 猫耳标题
  final String category;
  final List<Cat> categorieLists;

  CateCard({@required this.category, this.categorieLists});

  @override
  _CateCardState createState() => _CateCardState();
}

class _CateCardState extends State<CateCard> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      /// 层叠布局，让猫耳icon在左上角
      child: Stack(
        children: <Widget>[
          Container(
            width: screenWidth - 20,
            margin: const EdgeInsets.only(top: 30.0, bottom: 0.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Column(
              children: <Widget>[
                /// 标题
                Container(
                  width: screenWidth - 20,
                  padding: const EdgeInsets.only(left: 65.0, top: 3.0),
                  height: 30.0,
                  // 一级标题
                  child: Text(
                    widget.category,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                /// 网格布局
                _buildWidgetContainer(),
              ],
            ),
          ),
          /// 标题左边的icon
          Positioned(
            left: 0.0,
            top: 0.0,
            child: Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(23.0),
                  ),
                  height: 46.0,
                  width: 46.0,
                  child: Icon(
                    Icons.link,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWidgetContainer() {
    /// 没有数据显示空页面
    if (widget.categorieLists.length == 0) {
      return Container();
    }

    /// 有数据显示网格布局
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/paimaiLogo.png'),
            alignment: Alignment.bottomRight),
      ),
      child: CateCardContainer(
          categories: widget.categorieLists, columnCount: 3, isWidgetPoint: false),
    );
  }
}
