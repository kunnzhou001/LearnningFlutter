import 'package:flutter/material.dart';
import 'package:loan_flutter/gridViewDemo.dart';

class DemoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new DemoListState();
  }
}

class DemoListState extends State<DemoList> {
  final clicked = "";

  void _onClick() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new GridListDemo();
    }));
  }

  List<Widget> list = <Widget>[
    new ListTile(
      title: new Text('GridView',
          style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
      leading: new Icon(
        Icons.add,
        color: Colors.blue[500],
      ),
    ),
    new Divider(),
    new ListTile(
      title: new Text('ListView',
          style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
      leading: new Icon(
        Icons.add,
        color: Colors.blue[500],
      ),
    ),
    new Divider(),
    new ListTile(
      title: new Text('Stack',
          style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
      leading: new Icon(
        Icons.add,
        color: Colors.blue[500],
      ),
    ),
    new Divider(),
    new ListTile(
      title: new Text('Image',
          style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
      leading: new Icon(
        Icons.add,
        color: Colors.blue[500],
      ),
    ),
    // ...
    // See the rest of the column defined on GitHub:
    // https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/listview/main.dart
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Demo List'),
        centerTitle: true,
      ),
      body: _buildDemoList(),
    );
  }

  Widget _buildDemoList() {
    return new ListView(
      children: list,
    );
  }
}
