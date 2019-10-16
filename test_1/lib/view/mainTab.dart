import "package:flutter/material.dart";

const TextStyle optionStyle = TextStyle(fontSize: 8, fontWeight: FontWeight.bold);

const List<String> names = ["首页","会员","发布","通知","我的"];
const List<String> images = ["res/ic_user_center_unselect.png","res/ic_user_center.png"
                              ,"res/ic_user_center_unselect.png","res/ic_user_center.png"
                              ,"res/ic_user_center_unselect.png"];
const List<String> imageSelects = ["res/drawable/ic_user_center.png","res/drawable/ic_user_center.png"
                              ,"res/drawable/ic_user_center.png","res/drawable/ic_user_center.png"
                              ,"res/drawable/ic_user_center.png"];
// 自己定义了一个导航栏，其实系统提供了导航栏 BottomNavigationBar

class MainTabLayout extends StatelessWidget {

  int _currentSelect = 0;
  final List<MainTab> _mainTabList = List();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: _getMainTab(),
    );
  }

  List<MainTab> _getMainTab(){
    int i = 0;
    while(i < 5){
      print("i::$i");
      _mainTabList.add(MainTab(i, _onPressed));
      i++;
    }
    return _mainTabList;
  }

  void _onPressed(int index){
      print(index);
      if(index == _currentSelect){
        
      }else{
        _currentSelect = index;
        _mainTabList[index].select = false;
      }
  }
}

// class MainTab extends StatefulWidget{

//   MainTab({
//     int index,
//     Function onclick
//   });

//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _MainTabState(index,onclick);
//   }
// }

class MainTab extends StatelessWidget{

  int _index;
  final Function _onClick;
  bool select = false;
  final String image = "";
  final String imageSelect = "";
  final String name = "";

  MainTab(this._index,this._onClick){
    print("_index::$_index");
  }

  @override
  Widget build(BuildContext context) {
    print(_index);
    // TODO: implement build
    return Expanded(
      flex: 1,
      child: InkWell(    // 一个 material 风格的响应控件
        onTap:(){
          _onClick(_index);
          select = true;
        },
        child: Padding(
        padding: EdgeInsets.only(bottom: 6.0,top: 4.0),
        child: Column(
        children: <Widget>[
          Image.asset(_getImage(),width: 25,height: 25,),
          Text(
            name,
            style: optionStyle,)
        ],
      ))
      )
      );
  }
  
  // 收回上个备注的，一直为 null 是因为构造函数中MainTab(_index)  缺少了 this
  // 但是 onclick 点击还是不能改变ui
  String _getImage(){

    print(_index);
    // print(imageSelects[_index]);
    if(select){
      return imageSelects[_index];
    }else{
      return images[_index];
    }
  }
}