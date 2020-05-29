import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wanandroid/constant/color_config.dart';
import 'package:flutter_wanandroid/widgets/state/empty_view.dart';

///四种视图状态
enum LoadState { State_Success, State_Error, State_Loading, State_Empty }

/// 根据不同状态来展示不同的视图
class LoadStateLayout extends StatefulWidget {
  /// 页面状态
  final LoadState state;

  /// 成功视图
  final Widget successWidget;

  /// 错误事件处理
  final VoidCallback errorRetry;

  /// 空数据事件处理
  final VoidCallback emptyRetry;

  LoadStateLayout(
      {Key key,
      this.state = LoadState.State_Loading, //默认为加载状态
      this.successWidget,
      this.errorRetry,
      this.emptyRetry})
      : super(key: key);

  @override
  _LoadStateLayoutState createState() => _LoadStateLayoutState();
}

class _LoadStateLayoutState extends State<LoadStateLayout> {

  @override
  Widget build(BuildContext context) {
    return Container(
      //宽高都充满屏幕剩余空间
      width: double.infinity,
      height: double.infinity,
      child: _buildWidget,
    );
  }

  /// 根据不同状态来显示不同的视图
  Widget get _buildWidget {
    switch (widget.state) {
      case LoadState.State_Success:
        return widget.successWidget;
        break;
      case LoadState.State_Error:
        return _errorView;
        break;
      case LoadState.State_Loading:
        return _loadingView;
        break;
      case LoadState.State_Empty:
        return EmptyView(widget.emptyRetry);
        break;
      default:
        return null;
    }
  }

  /// 加载中视图
  Widget get _loadingView {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      color: Colors.white,
      child: Container(
        width: ScreenUtil().setWidth(750),
        height: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
//                width: 150,
//                height: 150,
                child: Image.asset('assets/images/23038-animatonblue.gif'),),
            SizedBox(
              height: 30.0,
            ),
            Text(
              '拼命加载中...',
              style: TextStyle(
                  color: ColorConfig.BLUE_200,
                  fontSize: ScreenUtil().setSp(40)),
            )
          ],
        ),
      ),
    );
  }

  /// 错误视图
  Widget get _errorView {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: InkWell(
          onTap: widget.errorRetry, // 回调，重试
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
//                  width: ScreenUtil().setWidth(405),
//                  height: ScreenUtil().setHeight(317),
                  child: Image.asset('assets/images/7903-error-404.gif'),),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "加载失败，请轻触重试!",
                style: TextStyle(
                    color: ColorConfig.BLUE_200,
                    fontSize: ScreenUtil().setSp(24)),
              ),
            ],
          ),
        ));
  }
}
