import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/views/about_page/page_dragger.dart';
import 'package:flutter_wanandroid/views/about_page/page_reveal.dart';
import 'package:flutter_wanandroid/views/about_page/pager_indicator.dart';
import 'package:flutter_wanandroid/views/about_page/pages.dart';


class AboutPage extends StatefulWidget{

  @override
  _AboutPageState createState() => _AboutPageState();

}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {

  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPageDragger animatedPageDragger;

  int activeIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  int nextPageIndex = 0;
  int waitingNextPageIndex = -1;

  double slidePercent = 0.0;
  // appbar 背景色修改
  var appBarBgColors = [0xFFcd344f,0xFF638de3,0xFFFF682D];

  _AboutPageState() {
    slideUpdateStream = new StreamController<SlideUpdate>();

    slideUpdateStream.stream.listen((SlideUpdate event) {
      if (mounted) {
        setState(() {
          // 拖动状态
          if (event.updateType == UpdateType.dragging) {
            slideDirection = event.direction;
            slidePercent = event.slidePercent;

            // 滑动方向
            if (slideDirection == SlideDirection.leftToRight) {
              nextPageIndex = activeIndex - 1;
            } else if (slideDirection == SlideDirection.rightToLeft) {
              nextPageIndex = activeIndex + 1;
            } else {
              nextPageIndex = activeIndex;
            }
          } else if (event.updateType == UpdateType.doneDragging) {
            // 结束拖动状态
            if (slidePercent > 0.5) {
              // 大于一半则打开新页
              animatedPageDragger = new AnimatedPageDragger(
                slideDirection: slideDirection,
                transitionGoal: TransitionGoal.open,
                slidePercent: slidePercent,
                slideUpdateStream: slideUpdateStream,
                vsync: this,
              );
            } else {
              // 否则显示原来页面
              animatedPageDragger = new AnimatedPageDragger(
                slideDirection: slideDirection,
                transitionGoal: TransitionGoal.close,
                slidePercent: slidePercent,
                slideUpdateStream: slideUpdateStream,
                vsync: this,
              );

              waitingNextPageIndex = activeIndex;
            }

            animatedPageDragger.run();
          } else if (event.updateType == UpdateType.animating) {
            // 动画在执行，将必要数据传递出去
            slideDirection = event.direction;
            slidePercent = event.slidePercent;
          } else if (event.updateType == UpdateType.doneAnimating) {
            // 动画执行结束
            if (waitingNextPageIndex != -1) {
              nextPageIndex = waitingNextPageIndex;
              waitingNextPageIndex = -1;
            } else {
              activeIndex = nextPageIndex;
            }

            slideDirection = SlideDirection.none;
            slidePercent = 0.0;

            animatedPageDragger.dispose();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    slideUpdateStream.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("关于"),
        backgroundColor: new Color(appBarBgColors[activeIndex]),
      ),
      body: new Stack(
        children: [
          new Page(
            // page 的主要内容
            viewModel: pages[activeIndex],
            percentVisible: 1.0,
          ),
          new PageReveal(
            revealPercent: slidePercent,
            child: new Page(
            viewModel: pages[nextPageIndex],
            percentVisible: slidePercent,
            ),
          ),
          new PagerIndicator(
            viewModel: new PagerIndicatorViewModel(
            pages,
            activeIndex,
            slideDirection,
            slidePercent,
            ),
          ),
          new PageDragger(
            canDragLeftToRight: activeIndex > 0,
            canDragRightToLeft: activeIndex < pages.length - 1,
            slideUpdateStream: this.slideUpdateStream,
            )
        ],
      )
    );
  }
}
