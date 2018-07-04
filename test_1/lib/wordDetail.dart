import 'package:flutter/material.dart';
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

  DetailViewState(this.detial);

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, detial);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('detail'),
            leading: IconButton(  // 通过这里监听返回  但是还不清楚怎么监听android的返回键
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