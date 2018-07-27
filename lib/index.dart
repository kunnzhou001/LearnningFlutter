import 'package:flutter/material.dart';
import 'package:loan_flutter/animated_list.dart';
import 'package:loan_flutter/loan/index_loan.dart';
import 'package:loan_flutter/loan/loan_values.dart';
import 'package:loan_flutter/loveName.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new IndexPageState();
  }
}

class IndexPageState extends State<IndexPage> {
  int _currentPageIndex = 0;

  var _bnbi = <BottomNavigationBarItem>[
    new BottomNavigationBarItem(
        icon: new Icon(Icons.monetization_on),
        title: new Text(LoanStrings.jieqian)),
    new BottomNavigationBarItem(
        icon: new Icon(Icons.shop), title: new Text("商城")),
    new BottomNavigationBarItem(
        icon: new Icon(Icons.person), title: new Text("我的")),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: _routPages[_currentPageIndex],
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _bnbi,
        onTap: (index) {
          setState(() {
            if (_currentPageIndex != index) {
              _currentPageIndex = index;
            }
          });
        },
        currentIndex: _currentPageIndex,
      ),
    );
  }

  var _routPages = [
    new IndexLoanPage(),
    new RandomWords(),
    new AnimatedListSample()
  ];
}
