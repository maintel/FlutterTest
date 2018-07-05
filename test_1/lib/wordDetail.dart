import 'package:flutter/material.dart';
import 'dart:async';
import './bean/Item.dart';


class WordDetailPage extends StatelessWidget{

   final Item detial;

  // 通过构造参数来传值
  WordDetailPage(this.detial);

  @override
  Widget build(BuildContext context) {
      // TODO: implement build
      return DetailView(detial);
    }

}

class DetailView extends StatefulWidget{

  final Item item;

  DetailView(this.item);

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return new DetailViewState(item);
    }
}

class DetailViewState extends State<DetailView> {

  final Item detial;
  int clickNum = 0;

  DetailViewState(this.detial);

  Future<bool> _checkCoundBack() {
          print(clickNum);
          if(clickNum == 0){
            clickNum++;
            return Future.value(false); // 这样的话就屏蔽了返回键
          } else {
            return Future.value(true);
          }
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return WillPopScope(  //监听按键
        onWillPop: () { // 监听android 返回键
          // Navigator.pop(context, detial);
          return _checkCoundBack();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('detail'),
            leading: IconButton(  // 通过这里监听返回  
              tooltip: 'back',
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, detial);
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  detial.isLike ? Icons.favorite : Icons.favorite_border,
                  color: detial.isLike ? Colors.red : null,
                  ),
                  onPressed: (){
                    setState(() {
                                        if(detial.isLike){
                                          detial.isLike = false;
                                        } else {
                                          detial.isLike = true;
                                        }
                                      });
                  },
              )
            ],
          ),
          body: Center(
            child: Text("word: " + detial.pair.asPascalCase ,style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w600),)
            ),
        )
      );
    }
}