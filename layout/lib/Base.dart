import 'package:flutter/material.dart';


///试着封装一个 baseLayout

class BaseLayout extends StatefulWidget {

  final String title;
  final Widget body;

  BaseLayout({
    this.title,
    this.body
  });

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return  new BaseView();
    }
}

class BaseView extends State<BaseLayout> {
  
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: widget.body,
      );
    }
}

//封装一哈~
class Button extends StatelessWidget {

  final String text;
  final VoidCallback onClick;

  Button({
    this.text,
    this.onClick
  });

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new RaisedButton(
          child: new Text(text),
          color: Colors.blueGrey,
          onPressed: onClick,
      );
    }
}


///封装一个带有分割线的 column

class MyColumn extends StatelessWidget {

  final Widget split;
  final List<Widget> children;

  MyColumn({
    this.split,
    this.children
  });

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Column(
        children: _buildChildren(),
      );
    }

  List<Widget> _buildChildren() {
    List<Widget> myChildren = new List();
    for (var item in children) {
      myChildren.add(item);
      if(split != null) {
        myChildren.add(split);
      }
    }
    if(split != null){
      myChildren.removeLast();
    }
    return myChildren;
  }
}

class MySizeBox extends StatelessWidget {

  final Widget child;
  final double width;
  final double height;

  MySizeBox({
    this.child,
    this.width = 200.0,
    this.height = 50.0
  });

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Container(
        color: Colors.green,
        child: new SizedBox(
          width: width,
          height: height,
          child: child,
        ),
      );
    }
}

/// fittedbox 页面的 条目封装
class FittedBoxItem extends StatelessWidget {

  final BoxFit boxFit;
  final String text;

  FittedBoxItem({
    this.boxFit,
    this.text,
  });


  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new MySizeBox(
            width: 200.0,
            height: 50.0,
            child: new FittedBox(
              fit: boxFit,
              child: new Text(text),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
          ),
          new MySizeBox(
            width: 100.0,
            height: 50.0,
            child: new FittedBox(
              fit: boxFit,
              child: new Text(text),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
          ),
          new MySizeBox(
            width: 50.0,
            height: 25.0,
            child: new FittedBox(
              fit: boxFit,
              child: new Text(text),
            ),
          )
        ],
      );
    }
}