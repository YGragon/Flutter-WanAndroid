
import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/views/about_page/pager_indicator.dart';


class PageDragger extends StatefulWidget {

  final canDragLeftToRight;
  final canDragRightToLeft;

  final StreamController<SlideUpdate> slideUpdateStream;


  PageDragger({
    this.canDragLeftToRight,
    this.canDragRightToLeft,
    this.slideUpdateStream,
  });

  @override
  _PageDraggerState createState() => _PageDraggerState();
}

class _PageDraggerState extends State<PageDragger> {

  static const FULL_TRANSTITION_PX = 300.0;

  Offset dragStart;
  SlideDirection slideDirection;
  double slidePercent = 0.0;

  // 拖拽开始
  onDragStart(DragStartDetails details){
    dragStart = details.globalPosition;
  }

  // 正在拖拽
  onDragUpdate(DragUpdateDetails details) {
    if (dragStart != null) {
      final newPosition = details.globalPosition;
      final dx = dragStart.dx - newPosition.dx;
      // 滑动方向
      if (dx > 0 && widget.canDragRightToLeft) {
        slideDirection = SlideDirection.rightToLeft;
      } else if (dx < 0 && widget.canDragLeftToRight) {
        slideDirection = SlideDirection.leftToRight;
      } else {
        slideDirection = SlideDirection.none;
      }
      // 滑动的百分比
      if (slideDirection != SlideDirection.none){
        slidePercent = (dx / FULL_TRANSTITION_PX).abs().clamp(0.0, 1.0);
      } else {
        slidePercent = 0.0;
      }
      // 添加 stream 数据
      widget.slideUpdateStream.add(
          new SlideUpdate(
              UpdateType.dragging,
              slideDirection,
              slidePercent
          ));
    }
  }

  // 拖拽结束
  onDragEnd(DragEndDetails details){
    // 添加 stream 数据
    widget.slideUpdateStream.add(
        new SlideUpdate(
          UpdateType.doneDragging,
          SlideDirection.none,
          0.0,
        )
    );

    dragStart = null;
  }

  @override
  Widget build(BuildContext context) {
    // 水平触摸监听
    return GestureDetector(
      onHorizontalDragStart: onDragStart ,
      onHorizontalDragUpdate: onDragUpdate ,
      onHorizontalDragEnd: onDragEnd ,
    );
  }
}

/// 动画控制
class AnimatedPageDragger{

  static const PERCENT_PER_MILLISECOND = 0.005;

  final slideDirection;
  final transitionGoal;

  AnimationController completionAnimationController;

  AnimatedPageDragger({
    this.slideDirection,
    this.transitionGoal,
    slidePercent,
    StreamController<SlideUpdate> slideUpdateStream,
    TickerProvider vsync,
  }) {
    final startSlidePercent = slidePercent;
    var endSlidePercent;
    var duration;

    // 关闭
    if ( transitionGoal == TransitionGoal.open){
      endSlidePercent = 1.0;

      final slideRemaining = 1.0 - slidePercent;

      duration = new Duration(
          milliseconds: (slideRemaining / PERCENT_PER_MILLISECOND).round()
      );

    } else {
      // 打开
      endSlidePercent = 0.0;
      duration = new Duration(
          milliseconds: (slidePercent / PERCENT_PER_MILLISECOND).round()
      );
    }

    completionAnimationController = new AnimationController(
        duration: duration,
        vsync: vsync
    )
      ..addListener((){
        slidePercent = lerpDouble(
            startSlidePercent,
            endSlidePercent,
            completionAnimationController.value
        );

        slideUpdateStream.add(
            new SlideUpdate(
              UpdateType.animating,
              slideDirection,
              slidePercent,
            )
        );

      })

      ..addStatusListener((AnimationStatus status){

        if(status == AnimationStatus.completed){
          slideUpdateStream.add(
              new SlideUpdate(
                UpdateType.doneAnimating,
                slideDirection,
                endSlidePercent,
              )
          );
        }

      });

  }

  run(){
    completionAnimationController.forward(from: 0.0);
  }

  dispose(){
    completionAnimationController.dispose();
  }

}

enum TransitionGoal{
  open,
  close,
}

enum UpdateType{
  dragging,
  doneDragging,
  animating,
  doneAnimating,
}

class SlideUpdate {
  // 拖拽的状态
  final updateType;
  // 拖拽的方向，打开或者关闭
  final direction;
  // 拖拽的百分比
  final slidePercent;

  SlideUpdate(
      this.updateType,
      this.direction,
      this.slidePercent
      );
}
