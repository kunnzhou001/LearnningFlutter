import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef void OnBannerClickListener(int index, dynamic itemData);
typedef Widget BuildShowView(int index, dynamic itemData);

const IntegerMax = 0x7fffffff;

class BannerView extends StatefulWidget {
  final OnBannerClickListener onBannerClickListener;

  //延迟多少秒进入下一页
  final int delayTime; //秒
  //滑动需要秒数
  final int scrollTime; //毫秒
  final double height;
  final List data;
  final BuildShowView buildShowView;
  final bool showIndex;

  BannerView(
      {Key key,
      @required this.data,
      @required this.buildShowView,
      this.onBannerClickListener,
      this.delayTime = 3,
      this.scrollTime = 200,
      this.showIndex,
      this.height = 200.0})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new BannerViewState();
}

class BannerViewState extends State<BannerView> {
//  double.infinity
  final pageController = new PageController();
  Timer timer;

  int _showIndex;

  @override
  void initState() {
    super.initState();
    resetTimer();
  }

  resetTimer() {
    clearTimer();
    timer = new Timer.periodic(new Duration(seconds: widget.delayTime),
        (Timer timer) {
      if (pageController.positions.isNotEmpty) {
        var i = pageController.page.toInt() + 1;
        pageController.animateToPage(i == 3 ? 0 : i,
            duration: new Duration(milliseconds: widget.scrollTime),
            curve: Curves.bounceInOut);
      }
    });
  }

  clearTimer() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
  }

  Widget _getIndexRow() {
    if (widget.showIndex) {
      List<Container> indexPoints = new List();
      print("_getIndexRow _showIndex = $_showIndex");
      for (var i = 0; i < widget.data.length; i++) {
        indexPoints.add(new Container(
          padding: const EdgeInsets.all(2.0),
          child: new Icon(Icons.brightness_1,
              size: 9.0,
              color: _showIndex == i ? Colors.white : Colors.black45),
        ));
      }
      return new Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: indexPoints);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQueryData.fromWindow(ui.window).size.width;

    return new SizedBox(
        height: widget.height,
        child: widget.data.length == 0
            ? null
            : new GestureDetector(
                onTap: () {
                  print(pageController.page);
                  print(pageController.page.round());
                  widget.onBannerClickListener(
                      pageController.page.round() % widget.data.length,
                      widget.data[
                          pageController.page.round() % widget.data.length]);
                },
                onTapDown: (details) {
//            print('onTapDown');
                  clearTimer();
                },
                onTapUp: (details) {
//            print('onTapUp');
                  resetTimer();
                },
                onTapCancel: () {
                  resetTimer();
                },
                child: new Stack(
                  alignment: const Alignment(0.0, 0.95),
                  children: <Widget>[
                    new PageView.builder(
                      controller: pageController,
                      physics: const PageScrollPhysics(
                          parent: const ClampingScrollPhysics()),
                      itemBuilder: (BuildContext context, int index) {
                        return widget.buildShowView(
                            index, widget.data[index % widget.data.length]);
                      },
                      onPageChanged: (index) {
                        setState(() {
                          _showIndex = index % widget.data.length;
                          print("_changeIndex index= $_showIndex");
                        });
                      },
                      itemCount: IntegerMax,
                    ),
                    _getIndexRow(),
                  ],
                )));
  }

  @override
  void dispose() {
    clearTimer();
    super.dispose();
  }
}
