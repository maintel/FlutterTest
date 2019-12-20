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
                indicatorColor: Color(0xff000000),
                indicatorPadding: EdgeInsets.all(20),
                indicatorSize: TabBarIndicatorSize.label,

                tabs: <Widget>[
                  InkWell(  
                    onTap: (){
                      print("click");
                    },
                    child: Text("2222"),
                  ),

                  Text("3333"),
                  Image.asset("res/ic_user_center.png")
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
          SecondPage(),
          SecondPage(),
          SecondPage()
        ],
      ),
    );
  }

}