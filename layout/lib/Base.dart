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
    myChildren.removeLast();
    return myChildren;
  }
}