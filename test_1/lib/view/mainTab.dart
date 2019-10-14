import "package:flutter/material.dart";

const TextStyle optionStyle = TextStyle(fontSize: 8, fontWeight: FontWeight.bold);


// 自己定义了一个导航栏，其实系统提供了导航栏 BottomNavigationBar

class MainTabLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        MainTab("首页", "res/drawable/ic_user_center.png"),
        MainTab("会员", "res/drawable/ic_user_center.png"),
        MainTab("发布", "res/drawable/ic_user_center.png"),
        MainTab("通知", "res/drawable/ic_user_center.png"),
        MainTab("我的", "res/drawable/ic_user_center.png"),
      ],
    );
  }
}

class MainTab extends StatelessWidget{

  final String name;
  final String image;


  MainTab(this.name,this.image);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.only(bottom: 6.0,top: 4.0),
        child: Column(
        children: <Widget>[
          Image.asset(image,width: 25,height: 25,),
          Text(
            name,
            style: optionStyle,)
        ],
      )),
      );
  }

}