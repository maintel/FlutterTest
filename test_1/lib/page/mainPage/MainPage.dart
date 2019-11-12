import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_1/page/secondPage/SecondPage.dart';


class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this,length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: Text("按钮"),
        title: TextField(),
        actions: <Widget>[
          Text("按钮1"),
          Text("按钮2")
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Text("1111"),
            Text("2222"),
            Text("3333")
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          SecondPage(),
          SecondPage(),
          SecondPage()
        ],
      ),
    );
  }

}