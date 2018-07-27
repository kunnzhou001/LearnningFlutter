import 'package:flutter/material.dart';
import 'package:loan_flutter/index.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'flutter 借条',
      theme: new ThemeData(
        scaffoldBackgroundColor: Color(0xFFFAFAFA),
        primaryColor: Color(0xFF19b955),
        bottomAppBarColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      home: new IndexPage(),
      routes: <String, WidgetBuilder>{
//        '/a': (BuildContext context) => new MyPage(title: 'page A'),
//        '/b': (BuildContext context) => new MyPage(title: 'page B'),
//        '/c': (BuildContext context) => new MyPage(title: 'page C'),
      },
    );
  }
}
