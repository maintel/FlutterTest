import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_1/page/settings/settingPage.dart';


class UserCenterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserCenterPageState();
  }
}

void _goSetting(BuildContext context){
  Navigator.push(context, 
    MaterialPageRoute(builder: (context) => SettingPage()));
}

class UserCenterPageState extends State{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        children: <Widget>[
          Text("user center page"),
          RaisedButton(
            onPressed: () => _goSetting(context),
            child: Text("设置"),
            )
        ],
      ),
    );
  }

}