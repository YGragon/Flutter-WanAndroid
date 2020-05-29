import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid/api/Api.dart';
import 'package:flutter_wanandroid/widgets/state/load_state.dart';
import 'package:flutter_wanandroid/api/http.dart';
import 'package:flutter_wanandroid/model/coin.dart';
import 'package:flutter_wanandroid/routers/navigation_service.dart';
import 'package:flutter_wanandroid/widgets/loading/dialog_manager.dart';

/// 排行榜页面
class CoinRankPage extends StatefulWidget {
  @override
  CoinRankPageState createState() => new CoinRankPageState();
}

class CoinRankPageState extends State<CoinRankPage> {
  EasyRefreshController _controller = EasyRefreshController();

  // 页码
  int _page = 1;

  // 控制结束
  bool _enableControlFinish = false;

  List<CoinInfo> _coinList = [];

  @override
  void initState() {
    super.initState();
    _getCoinList(_page);
  }

  Future<void> _getCoinList(int page) async {
    /// 获取排行榜的数据
    Http.getData(Api.COIN_RANK + "$page/json", success: (data) {
      var coin = Coin.fromJson(data);
      _coinList.addAll(coin.data.datas);
      if(_coinList.length <= 0){
        _layoutState = LoadState.State_Empty;
      }else{
        _layoutState = LoadState.State_Success;
      }
      setState(() {
        _layoutState = _layoutState;
        _coinList = _coinList;
      });
    }, error: (e) {
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
          child: Text(
            '${_coinList[index].rank}',
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          '🔥 ${_coinList[index].coinCount}',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 17.0),
        ),
        subtitle: Text('🎅 ${_coinList[index].username}'),
      ),
    );
  }

  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  void _retry() {
    setState(() {
      _layoutState = LoadState.State_Loading;
    });
    _getCoinList(1);
  }

  Future _refreshData() async {
    _coinList.clear();
    _page = 1;
    await _getCoinList(_page);
    if (!_enableControlFinish) {
      _controller.resetLoadState();
      _controller.finishRefresh();
    }
  }

  Future _loadMoreData() async {
    _page++;
    await _getCoinList(_page);
    if (!_enableControlFinish) {
      _controller.finishLoad();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('积分排行榜'),
        ),
        body: LoadStateLayout(
          state: _layoutState,
          emptyRetry: () {
            _retry();
          },
          errorRetry: () {
            _retry();
          }, //错误按钮点击过后进行重新加载
          successWidget: Center(
            child: EasyRefresh.custom(
              enableControlFinishRefresh: true,
              enableControlFinishLoad: true,
              controller: _controller,
              onRefresh: () async {
                await _refreshData();
              },
              onLoad: () async {
                await _loadMoreData();
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
