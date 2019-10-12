import 'package:flutter/material.dart';

/// 主页
class MainClass extends StatefulWidget{

  @override
  createState() => MainState();
}

class MainState extends State{
  @override
  Widget build(BuildContext context) {
    //Scaffold （脚手架）
    // 类似于下面这个内容，它包含一个appBar  ，然后 body 中是内容，放了一个 center 的布局，布局中包含一个 Text，
    return Scaffold(
        appBar: AppBar(
          title: Text("test"),
        ),
        body: Center(
          child: Text("center"),
        ),
    );
  }
}