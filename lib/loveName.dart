import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RandowWordState();
  }
}

class RandowWordState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement builde
    return new Scaffold(
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return new Divider();
        }

        final index = i ~/ 2;

        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return _buildRow(index);
      },
    );
  }

  Widget _buildRow(int index) {
    WordPair pair = _suggestions[index];
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        index.toString() + " " + pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
        Navigator.pop(context, pair);
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final titles = _saved.map((pair) {
        return new ListTile(
          title: new Text(pair.asPascalCase, style: _biggerFont),
        );
      });
      final divers =
          ListTile.divideTiles(context: context, tiles: titles).toList();
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("My LOVE"),
        ),
        body: new ListView(children: divers),
      );
    }));
  }

  void _back() {}
}
