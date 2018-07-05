import 'package:flutter/material.dart';
import './Base.dart';

const String ALIGN_LAYOUT = "align_layout";
const String PADDING_LAYOUT = "padding_layout";
const String CENTER_LAYOUT = "CENTER_LAYOUT";
const String FITTEDBOX_LAYOUT = "FittedBox Page";


class SingleChildLayout extends StatefulWidget {

  final String name;

  SingleChildLayout({this.name});

  @override
  State<StatefulWidget> createState() {
      // TODO: implement createState
      return _disptchRoute(name);
    }

  State<SingleChildLayout> _disptchRoute(String name) {
    switch(name) {
      case ALIGN_LAYOUT:
          return new AlignLayout();
        break;
      case PADDING_LAYOUT:
          return new PaddingLayout();
        break;
      case CENTER_LAYOUT:
          return new Layout();
      default:
          return new Layout();
        break;
    }
  }
}

class Layout extends State<SingleChildLayout> {

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new BaseLayout(
        title: widget.name,
        body: _buildBody() 
      );
    }

    Widget _buildBody() {
      switch(widget.name) {
        case CENTER_LAYOUT:
            return _centerWidget();
          break;
        case FITTEDBOX_LAYOUT:
          return _fittedBoxWidget();
      }
      return new Text(widget.name);
    }
}

Widget _fittedBoxWidget() {
  return new Center(
    widthFactor: 1.0,
    heightFactor: 1.0,
    child: 
      new FittedBox(
        alignment: Alignment.bottomLeft,
        fit: BoxFit.cover,
        child: new Text("aaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccdddddddddddddeeeeeeeee"),
      )
  );
}

Widget _centerWidget() {

  /// center 如果不设置 widthFactor 和 heightFactor 的话会占用尽可能大的空间
  /// 同样的他的位置计算也和父布局有关

  return new Center(
    child: new Column(
      children: <Widget>[
        new Center(
          heightFactor: 10.0,
          child: new Text("center Column and 10 heightFactor"),
        ),
        new Container(
          child: new Center(
            child: new Text("cent center"),
          ),
        )
      ],
    )
  );

}


/// Align 布局

class AlignLayout extends State<SingleChildLayout>{

  ///
  /// Align 的默认宽高是充满整个父布局的？还是和他的父布局有关系？
  ///父布局为 stack 时，他貌似是充满父布局的，当父布局为 Column 时不是。
  ///Align 的子控件默认是居中的。

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new BaseLayout(
        title: "AlignLayout pages",
        body: new Stack(
            children: <Widget>[
              new Align(
                alignment: Alignment.centerLeft,
                widthFactor: 5.0,
                heightFactor: 10.0,
                child: new Text("w 5 h 10 center left"),
              ),
              new Align(
                alignment: Alignment.bottomRight,
                child: new Text("bottom right"),
              ),
              new Align(
                alignment: Alignment.bottomLeft,
                child: new Text("bottom left"),
              ),
              new Text("why"),
              new Column(
                children: <Widget>[
                  new Align(
                    heightFactor: 10.0,
                    child: new Text("A align layout in column"),
                  ),
                  new Text("below A align layout in column")
                ],
              ),
              new Align(
                heightFactor: 5.0,
                alignment: Alignment.bottomRight,
                child: new Text("bottom Right"),
              ),
              new Text("Test")
            ],
          ),
        );
    }
}

class PaddingLayout extends State<SingleChildLayout> {


  ///Padding 布局只有一个属性就是 padding 值。
  ///在复杂情况下可以使用同样支持 padding 值得 Container 布局来替代。


  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new BaseLayout(
        title: "Padding Layout Pages",
        body: new Padding(
          padding: const EdgeInsets.all(18.0),
          child: new Column(
            children: <Widget>[
                new Container(
                  padding: const EdgeInsets.all(9.0),
                  margin: const EdgeInsets.only(bottom: 10.0),
                  color: Colors.lightGreen,
                  child: new Text("adadad"),
                ),
                new Text("aaaa")
            ],
          )
        )
      );
    }
}