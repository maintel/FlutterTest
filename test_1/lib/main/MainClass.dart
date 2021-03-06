import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_1/page/fourPage/FourPage.dart';
import 'package:test_1/page/mainPage/MainPage.dart';
import 'package:test_1/page/secondPage/SecondPage.dart';
import 'package:test_1/page/threePage/ThreePage.dart';
import 'package:test_1/page/userCenterPage/UserCenterPage.dart';
import '../view/mainTab.dart';

/// 主页
class MainClass extends StatefulWidget{

  @override
  createState() => MainState();
}

class MainState extends State{

  int _index = 0;

  List<StatefulWidget> pageList = [
      MainPage(),
      SecondPage(),
      ThreePage(),
      FourPage(),
      UserCenterPage()
  ];

  @override
  Widget build(BuildContext context) {
    //Scaffold （脚手架）
    // 类似于下面这个内容，它包含一个appBar  ，然后 body 中是内容，放了一个 center 的布局，布局中包含一个 Text，
    return Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(    //expanded 布局会充满父布局，从而导致外层也充满父布局
              child: Center(
                child: pageList[_index]
              ),
            ),
            MainTabLayout(onSelectChange: _onSelectChange,),
          ]
        ),
    );
  }

  void _onSelectChange(int index){
    print("select::$index");
    setState(() {
     _index = index; 
    });
  }
}