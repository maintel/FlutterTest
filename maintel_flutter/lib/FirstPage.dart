import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:maintel_flutter/widget/picker/show_picker.dart';
import 'package:maintel_flutter/widget/picker/time_picker/my_time_picker_widget.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        //此处
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
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
  var now = DateTime.now();

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
            onPressed: () => _showDate(),
            child: Text("show Date"),
          ),
          RaisedButton(
            onPressed: () => _showCityPicker(),
            child: Text("show city picker"),
          ),
          RaisedButton(
            onPressed: () => _showListPicker(),
            child: Text("show my list picker"),
          ),
          RaisedButton(
            onPressed: () => _showDatePicker(),
            child: Text("show my date picker"),
          ),
          // Expanded(
          //     child: Container(
          //   height: 200,
          //   child: CupertinoTimerPicker(
          //     initialTimerDuration: Duration(
          //         hours: now.hour, minutes: now.minute, seconds: now.second),
          //     onTimerDurationChanged: (Duration duration) {},
          //   ),
          // )),
          Container(
            height: 300,
            child: MyTimePicker(model:TimePiclerType.YearMothDayHourMin,startTime: DateTime(2015,5,25),endTime: DateTime(2019,8,10),),
          )
        ],
      ),
    );
  }

  void _showTime() async {
    var time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  void _showDate() async {
    await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1992), lastDate: DateTime(2025));
  }

  _showCityPicker() async {
    // showListPicker(context);
    await CityPickers.showCityPicker(context: context);
  }

  _showListPicker() async {
    await showListPicker(context, ["aaa", "bbb", "1111", "78787", "66666"])
        .then((value) {
      print(value.toString());
    });
  }

  _showDatePicker() async {}
}
