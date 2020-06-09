import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:maintel_flutter/widget/picker/list_picker/test.dart';
import 'package:maintel_flutter/widget/picker/show_picker.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      home: FirstPageWidget(),
    );
  }
}

class FirstPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FirstPageState();
  }
}

class _FirstPageState extends State<FirstPageWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Picker Page"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () => _showTime(),
            child: Text("show Time"),
          ),
          RaisedButton(
            onPressed: () => _showCityPicker(),
            child: Text("show city picker"),
          ),
          RaisedButton(
            onPressed: () => _showListPicker(),
            child: Text("show list picker"),
          ),
          // Expanded(child: CupertinoDatePicker(onDateTimeChanged:(time) => {

          // }))
          Container(
            height: 200,
            child: MyCupertinoPicker(
              backgroundColor: Colors.white,
              diameterRatio:3,  ///纵向滚动的曲率，默认是1.1 越小弯曲越厉害
              itemExtent: 30.0,  /// 选中条目的高度
              offAxisFraction: 0,  /// 横轴方向的弧度
              squeeze:1,     ///紧凑程度 值越大条目之间越紧凑
              magnification:1.0,  ///选中区域放大倍率
              children: <Widget>[
                Text("aaa"),
                Text("bbb"),
                Text("cccc"),
                Text("dddd"),
                Text("eee"),
                Text("fff"),
                Text("ggg"),
                Text("hhh"),
                Text("iii"),
                Text("jjjj"),

              ],
            ),
          )
        ],
      ),
    );
  }

  void _showTime() async {
    var time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  _showCityPicker() async {
    // showListPicker(context);
    await CityPickers.showCityPicker(context: context);
  }

  _showListPicker() async {
    showListPicker(context);
  }
}
