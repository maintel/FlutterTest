import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import './wordDetail.dart';
import './bean/Item.dart';

class RandomWords extends StatefulWidget{

  @override
  createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords>{

  final _suggestiongs = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  final _save = Set<WordPair>();

  //生成列表
  Widget _buidSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i){
        if(i.isOdd) {
          // 画条横线
          return Divider(color:Colors.red,);
        }
        final index = i ~/ 2;
        // 扩容
        if (index >= _suggestiongs.length) {
          _suggestiongs.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestiongs[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {

    final alreadSaved = _save.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: IconButton(
        icon: Icon(
          alreadSaved ? Icons.favorite : Icons.favorite_border,
          color: alreadSaved ? Colors.red : null,
        ),
        onPressed: () => _savePair(pair,alreadSaved),
      ),
      onTap: () {
        _navigateDetail(pair, alreadSaved);
      },
    );
  }

  _navigateDetail(WordPair pair, bool alreadSaved) async {
     final Item result = await Navigator.push(context, MaterialPageRoute(builder: (context) => WordDetailPage(new Item(pair, alreadSaved))));
     if(result == null) {
       return;
     }
     if(result.isLike) {
       _save.add(result.pair);
     } else {
       _save.remove(result.pair);
     }
  }

  void _savePair(WordPair pair, bool isSave) {
    setState(() {
          if (isSave) {
            _save.remove(pair);
          } else {
            _save.add(pair);
          }
        });
  }

  void _pushSaved() {
    // 通过 Navigator 来跳转
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          final tites = _save.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            }
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tites
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('感兴趣列表'),
            ),
            body: ListView(children: divided,),
          );
        }
      )
    );
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          title: Text('单词列表'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list),onPressed: _pushSaved,)
          ],
        ),
        body: _buidSuggestions(),
      );
    }
}