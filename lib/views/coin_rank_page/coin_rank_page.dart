import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid/api/Api.dart';
import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/components/search_input.dart';
import 'package:flutter_wanandroid/event/event_bus.dart';
import 'package:flutter_wanandroid/event/event_model.dart';
import 'package:flutter_wanandroid/model/coin.dart';
import 'package:flutter_wanandroid/model/collect.dart';
import 'package:flutter_wanandroid/routers/application.dart';
import 'package:flutter_wanandroid/routers/navigation_service.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/views/search_page/search_page.dart';
import 'package:flutter_wanandroid/widgets/loading/dialog_manager.dart';
/// 排行榜页面
class CoinRankPage extends StatefulWidget{
  @override
  CoinRankPageState  createState() => new CoinRankPageState();
}

class CoinRankPageState extends State<CoinRankPage>{
  EasyRefreshController _controller = EasyRefreshController();

  // 页码
  int _page = 1;
  // 方向
  Axis _direction = Axis.vertical;
  // 控制结束
  bool _enableControlFinish = false;

  List<CoinInfo> _coinList = [];


  @override
  void initState() {
    super.initState();
    _getCoinList(_page);
  }

  Future<void> _getCoinList(int page) async {
    print("context:${NavigationService.mContext}");
    /// 获取排行榜的数据
    DioManager().get(Api.COIN_RANK + "$page/json",showLoading:(){
      Future.delayed(Duration(milliseconds: 200)).then((e) {
        DialogManager.showBasicDialog(NavigationService.mContext, "正在加载中...");
      });
    },hideLoading:(){
        Navigator.pop(NavigationService.mContext);
    },success: (data){
      var coin = Coin.fromJson(data);
      _coinList.addAll(coin.data.datas);

      setState(() {
        _coinList = _coinList;
      });
    },error: (e){
      print("接口出错：${e.message}");
    });
  }

  Widget _renderItem(context, index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      margin: const EdgeInsets.only(bottom: 7.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            color: const Color(0xFFd0d0d0),
            blurRadius: 1.0,
            spreadRadius: 2.0,
            offset: Offset(3.0, 2.0),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Text('${_coinList[index].rank}',style: TextStyle(color: Colors.white),),
        ),
        title: Text(
          '🔥 ${_coinList[index].coinCount}',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 17.0),
        ),
        subtitle: Text(
          '🎅 ${_coinList[index].username}'
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text('积分排行榜'),
        ),
        body: Center(
          child: Container(
            height: _direction == Axis.vertical ? double.infinity : 210.0,
            child: EasyRefresh.custom(
              enableControlFinishRefresh: true,
              enableControlFinishLoad: true,
              controller: _controller,
              onRefresh: () async {
                _coinList.clear();
                _page = 1;
                await _getCoinList(_page);
                if (!_enableControlFinish) {
                  _controller.resetLoadState();
                  _controller.finishRefresh();
                }
              },
              onLoad: () async {
                _page++;
                await _getCoinList(_page);
                if (!_enableControlFinish) {
                  _controller.finishLoad();
                }
              },
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return _renderItem(context, index);
                    },
                    childCount: _coinList.length,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

}