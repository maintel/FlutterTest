import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_1/page/mainPage/AttentionPage.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Color(0xffffffff),
          brightness:Brightness.light ,
          leading: Text("按钮"),
          title: TextField(
            obscureText: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(),
              labelText: "澳门回归20周年"
            ),
            maxLines: 1,
          ),  //输入框
          actions: <Widget>[
            Text("按钮1"),
            Text("按钮2")
          ],
          bottom:TabBar(
                controller: _tabController,
                indicatorColor: Color(0xffaa00bb),
                tabs: <Widget>[
                  Text("关注"),
                  Text("推荐"),
                  Text("热榜")
                ],
                onTap: (value) {
                    print(value);
                },
              ),
            ),
          ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          AttentionPage(),
          SecondPage(),
          SecondPage()
        ],
      ),
    );
  }
}