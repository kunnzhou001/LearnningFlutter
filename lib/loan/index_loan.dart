import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loan_flutter/banner.dart';
import 'package:loan_flutter/loan/loan_values.dart';
import 'package:loan_flutter/loan/platformMethod.dart';

class IndexLoanPage extends StatefulWidget {
  IndexLoanPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() {
    // TODO: implement createState
    return new _IndexPageState();
  }
}

class _IndexPageState extends State<IndexLoanPage> with WidgetsBindingObserver {
  bool _hasNoReadMessage = false;

  List<ActiveItem> _actionItems;

  var _textEditController = new TextEditingController();

  var _focusNode = new FocusNode();

  String textValue;

  /*
resumed - 应用程序可见并响应用户输入。这是来自Android的onResume
inactive - 应用程序处于非活动状态，并且未接收用户输入。此事件在Android上未使用，仅适用于iOS
paused - 应用程序当前对用户不可见，不响应用户输入，并在后台运行。这是来自Android的暂停
suspending - 该应用程序将暂时中止。这在iOS上未使用
   */
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    print("生命周期改变：" + state.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getMessageNo();
    _getActives();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView(
      children: <Widget>[
        _buildBannerView(),
        new Card(
          margin: EdgeInsets.all(12.0),
          child: _buildHome(),
        ),
      ],
    );
  }

  Widget _buildBannerView() {
    List<String> urlList = <String>[
      "https://cdn-daikuan.360jie.com.cn/pic/aaf798d4b7b5cbb91066673c53387bcd.png?max_age=2592000",
      'http://cdn-daikuan.360jie.com.cn/pic/songhuafei%20banner.png?max_age=2592000',
      'https://cdn-daikuan.360jie.com.cn/pic/91ea69b36bae570ecc6e556153e9ba08.jpg?max_age=2592000',
      'https://cdn-daikuan.360jie.com.cn/pic/3a42b3d3231a0cdde4964b362e7d59f2.png?max_age=2592000',
      'https://cdn-daikuan.360jie.com.cn/pic/hehuoren%20banner.png?max_age=2592000'
    ];

    Widget _buildBannerItem(int index, data) {
      int dex = index % urlList.length;
      print("_buildBannerItem index = $dex");
      return new Container(
        child: new FadeInImage.assetNetwork(
            placeholder: "images/default-banner.png",
            fit: BoxFit.cover,
            image: data),
      );
    }

    return new Stack(
      alignment: const Alignment(0.95, -0.95),
      children: <Widget>[
        new BannerView(
          data: urlList,
          delayTime: 5,
          height: 180.0,
          showIndex: true,
          buildShowView: (index, data) {
            return _buildBannerItem(index, data);
          },
          onBannerClickListener: (index, data) {
            var _bannerIndex = index + 1;
            Scaffold.of(context).showSnackBar(new SnackBar(
                backgroundColor: Colors.white,
                content: new Container(
                  decoration: new BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  alignment: Alignment.center,
                  height: 40.0,
                  child: new Text("点击了第$_bannerIndex个广告",
                      style: new TextStyle(fontSize: 16.0)),
                )));
          },
        ),
        new Container(
          height: 40.0,
          width: 40.0,
          child: new Image.asset(_hasNoReadMessage
              ? "images/message.png"
              : "images/messageNo.png"),
        )
      ],
    );
  }

  Widget _buildHome() {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text(LoanStrings.zuigaokejieedu,
              style: new TextStyle(color: Colors.black38, fontSize: 15.0)),
          new Text(
            LoanStrings.ershiwan,
            key: new Key("edu"),
            style: new TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 48.0,
                color: Colors.black87),
          ),
          new Text(LoanStrings.dailyfee,
              style: new TextStyle(color: Colors.black38, fontSize: 15.0)),
          _phoneEdit(),
          _loanButton()
        ],
      ),
    );
  }

  Widget _loanButton() {
    return new GestureDetector(
        child: new Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: new Container(
            decoration: new BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(6.0),
            ),
            height: 48.0,
            alignment: Alignment.center,
            child: new Text(
              LoanStrings.want_loan,
              style: new TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        ),
        onTap: _verifyNum);
  }

  _verifyNum() {
    print(_textEditController.text);
    if (_textEditController.text.length < 11) {
      LocalPlatformMethod.showTip(LocalPlatformMethod.LENGTH_SHORT,
          LoanStrings.input_right_phone_number);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => new Center(
                heightFactor: 80.0,
                child: new CircularProgressIndicator(
                  backgroundColor: Colors.green,
                ),
              ));
    }
  }

  Widget _phoneEdit() {
    return new Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: new Container(
            padding: EdgeInsets.all(2.0),
            decoration: new BoxDecoration(
                border: Border.all(color: Colors.black38, width: 1.5),
                borderRadius: BorderRadius.circular(8.0)),
            child: new Row(
              children: <Widget>[
                new Icon(
                  Icons.phone_android,
                  color: Colors.black38,
                ),
                new Expanded(
                    child: new TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: LoanStrings.phoneNum_input_hint_text,
                      hintStyle:
                          new TextStyle(color: Colors.black38, fontSize: 14.0),
                      border: InputBorder.none),
                  controller: _textEditController,
                  focusNode: _focusNode,
                  onChanged: (text) {
                    if (text.length == 11) {
                      _focusNode.unfocus();
                    }
                    if (text.length >= 11) {
                      textValue = text;
                    }
                  },
                ))
              ],
            )));
  }

  void _getMessageNo() {
    new Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _hasNoReadMessage = true;
      });
    });
  }

  void _getActives() {
    _actionItems = <ActiveItem>[
      new ActiveItem(
          imageUrl: "images/default_activity.png",
          title: "邀请",
          subTitle: "邀请赚现金"),
      new ActiveItem(
          imageUrl: "images/default_activity.png",
          title: "提额",
          subTitle: "邀请赚现金"),
      new ActiveItem(
          imageUrl: "images/default_activity.png",
          title: "合伙人",
          subTitle: "邀请赚现金"),
      new ActiveItem(
          imageUrl: "images/default_activity.png",
          title: "优惠券",
          subTitle: "邀请赚现金"),
    ];
  }
}

typedef void ActiviTapCallback(ActiveItem item);

class ActiveItem {
  ActiveItem(
      {this.imageUrl, this.title, this.subTitle, this.herf, this.onActiviTap});

  final String imageUrl;
  final String title;
  final String herf;
  final String subTitle;
  final ActiviTapCallback onActiviTap;

  String get tag => imageUrl; //Assuming that all asset names are unique.
}
