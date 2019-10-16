import "package:flutter/material.dart";

const TextStyle optionStyle = TextStyle(fontSize: 8, fontWeight: FontWeight.bold);

const List<String> names = ["首页","会员","发布","通知","我的"];
const List<String> images = ["res/drawable/ic_user_center_unselect.png","res/drawable/ic_user_center_unselect.png"
                              ,"res/drawable/ic_user_center_unselect.png","res/drawable/ic_user_center_unselect.png"
                              ,"res/drawable/ic_user_center_unselect.png"];
const List<String> imageSelects = ["res/drawable/ic_user_center.png","res/drawable/ic_user_center.png"
                              ,"res/drawable/ic_user_center.png","res/drawable/ic_user_center.png"
                              ,"res/drawable/ic_user_center.png"];
// 自己定义了一个导航栏，其实系统提供了导航栏 BottomNavigationBar

class MainTabLayout extends StatelessWidget {

                            

  final int _currentSelect = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: _getMainTab(),
    );
  }

  List<MainTab> _getMainTab(){
    
    List<MainTab> mainTabList = List();
    int i = 0;
    while(i < 5){
      mainTabList.add(MainTab(i, _onPressed));
      i++;
    }
    return mainTabList;
  }

  void _onPressed(int index){
      print(index);
  }
}

class MainTab extends StatelessWidget{

  final int _index = 0;
  Function _onClick;

  MainTab(index,this._onClick);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      flex: 1,
      child: InkWell(    // 一个 material 风格的响应控件
        onTap:(){
          _onClick(_index);
        },
        child: Padding(
        padding: EdgeInsets.only(bottom: 6.0,top: 4.0),
        child: Column(
        children: <Widget>[
          Image.asset(images[_index],width: 25,height: 25,),
          Text(
            names[_index],
            style: optionStyle,)
        ],
      ))
      )
      );
  }
}