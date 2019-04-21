import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/api/common_service.dart';
import 'package:flutter_wanandroid/components/cate_card_container.dart';
import 'package:flutter_wanandroid/model/car.dart';

class CateCard extends StatefulWidget {
  final String category;
  CateCard({@required this.category});

  @override
  _CateCardState createState() => _CateCardState();
}

class _CateCardState extends State<CateCard> {

  List<Cat> categories = [];


  @override
  void initState() {
    super.initState();
    getFirstChildCategoriesByParentId();
  }

  // 获取一层目录下的二级内容
  getFirstChildCategoriesByParentId() async {

    /// 获取猫耳列表数据
    /// 体系、项目、导航
      categories.clear();
      /// TODO 得到的结果做为一个 猫耳 布局, 获取子集合 显示新的猫耳布局
      CommonService().getSystemTree((CatModel catModel) {
        if(!mounted){
          return;
        }
        setState(() {
          categories.addAll(catModel.data);
        });
      });

      /// TODO 得到的结果做为一个 猫耳 布局，model 还需要调整，
      CommonService().getNaviList((CatModel catModel) {
        if(!mounted){
          return;
        }
        setState(() {
          categories.addAll(catModel.data);
        });
      });

      /// TODO 得到的结果做为一个 猫耳 布局
      CommonService().getProjectTree((CatModel catModel) {
        if(!mounted){
          return;
        }
        setState(() {
          categories.addAll(catModel.data);
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                _buildWidgetContainer(),
              ],
            ),
          ),
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
    if (this.categories.length == 0) {
      return Container();
    }
    /// 有数据显示网格布局
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/paimaiLogo.png'),
            alignment: Alignment.bottomRight
        ),
      ),
      child: CateCardContainer(
          categories: this.categories,
          columnCount: 3,
          isWidgetPoint:false
      ),
    );
  }
}
