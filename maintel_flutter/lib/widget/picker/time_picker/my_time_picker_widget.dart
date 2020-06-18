import 'package:flutter/material.dart';
import 'package:maintel_flutter/utils/data_utils.dart';
import 'package:maintel_flutter/widget/picker/list_picker/list_picker_wheel.dart';

/// 有六种种格式
/// - 时：分
/// - 时：分：秒
/// - 月：日
/// - 年：月
/// - 年：月：日
/// - 年：月：日：时：分
/// - 年：月：日：时：分：秒
enum TimePiclerType {
  HourMin,
  HourMinSec,
  MonthDay,
  YearMoth,
  YearMothDay,
  YearMothDayHourMin,
  All,
}

class MyTimePicker extends StatefulWidget {
  TimePiclerType model;
  List<String> dateFormat;

  MyTimePicker(
      {this.model = TimePiclerType.YearMothDay,
      this.dateFormat = DATE_FORMAT_DATE_TIME});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyTimePickerWdiget();
  }
}

class _MyTimePickerWdiget extends State<MyTimePicker> {
  int _selectYear;
  int _selectMonth;
  int _selectHour;
  int _selectMin;
  int _selectSecond;
  int _selectDay;

  int _mothDay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime _nowTime = DateTime.now();
    _selectYear = _nowTime.year;
    _selectMonth = _nowTime.month;
    _selectDay = _nowTime.day;
    _selectHour = _nowTime.hour;
    _selectMin = _nowTime.minute;
    _selectSecond = _nowTime.second;
    _mothDay = getDaysInMonth(_selectYear, _selectMonth);
    print(_nowTime);
    print(_selectDay);
    print(_selectMonth);
    print(formatDate(DateTime.now(),
        [yyyy, "-", MM, "-", dd, " ", DD, " ", HH, ":", mm, ":", ss]));
    print(formatDate(DateTime.now(), DEFAULT_TIME_FORMAT));
  }

  /// 小时选择
  _buildHourWheel() {
    return MyCupertinoPicker(
        scrollController: FixedExtentScrollController(initialItem: _selectHour),
        children: List<Widget>.generate(24, (index) {
          return Text("${index}时");
        }));
  }

  /// 分钟选择
  _buildMinWheel() {
    return MyCupertinoPicker(
        scrollController: FixedExtentScrollController(initialItem: _selectMin),
        children: List<Widget>.generate(60, (index) {
          return Text("${index}分");
        }));
  }

  /// 秒选择
  _buildSecWheel() {
    return MyCupertinoPicker(
        scrollController:
            FixedExtentScrollController(initialItem: _selectSecond),
        children: List<Widget>.generate(60, (index) {
          return Text("${index}秒");
        }));
  }

  _buildYearWheel() {
    return MyCupertinoPicker(
        scrollController:
            FixedExtentScrollController(initialItem: _selectYear - 1970),
        children: List<Widget>.generate(60, (index) {
          return Text("${1970 + index}年");
        }));
  }

  _selectMothChange(int monthIndex) {
    setState(() {
      _selectMonth = monthIndex + 1;
      _mothDay = getDaysInMonth(_selectYear, _selectMonth);
    });
  }

  _buildMonthWheel() {
    return MyCupertinoPicker(
        onSelectedItemChanged: (value) => _selectMothChange(value),
        scrollController:
            FixedExtentScrollController(initialItem: _selectMonth - 1),
        children: List<Widget>.generate(12, (index) {
          return Text("${index + 1}月");
        }));
  }

  _buildDayWheel() {
    return MyCupertinoPicker(
        key: Key("$_selectMonth"),
        scrollController:
            FixedExtentScrollController(initialItem: _selectDay - 1),
        children: List<Widget>.generate(_mothDay, (index) {
          return Text("${index + 1}日");
        }));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> timeWheels = List<Widget>();
    switch (widget.model) {
      case TimePiclerType.HourMin:
        timeWheels.add(_buildHourWheel());
        timeWheels.add(_buildMinWheel());
        break;
      case TimePiclerType.HourMinSec:
        timeWheels.add(_buildHourWheel());
        timeWheels.add(_buildMinWheel());
        timeWheels.add(_buildSecWheel());
        break;
      case TimePiclerType.MonthDay:
        timeWheels.add(_buildMonthWheel());
        timeWheels.add(_buildDayWheel());
        break;
      case TimePiclerType.YearMoth:
        timeWheels.add(_buildYearWheel());
        timeWheels.add(_buildMonthWheel());
        break;
      case TimePiclerType.YearMothDay:
        timeWheels.add(_buildYearWheel());
        timeWheels.add(_buildMonthWheel());
        timeWheels.add(_buildDayWheel());
        break;
      case TimePiclerType.YearMothDayHourMin:
        timeWheels.add(_buildYearWheel());
        timeWheels.add(_buildMonthWheel());
        timeWheels.add(_buildDayWheel());
        timeWheels.add(_buildHourWheel());
        timeWheels.add(_buildMinWheel());
        break;
      case TimePiclerType.All:
        timeWheels.add(_buildYearWheel());
        timeWheels.add(_buildMonthWheel());
        timeWheels.add(_buildDayWheel());
        timeWheels.add(_buildHourWheel());
        timeWheels.add(_buildMinWheel());
        timeWheels.add(_buildSecWheel());
        break;
      default:
        timeWheels.add(_buildYearWheel());
        timeWheels.add(_buildMonthWheel());
        timeWheels.add(_buildDayWheel());
    }

    return Row(
        children: timeWheels
            .map((item) => Expanded(
                  child: item,
                ))
            .toList(growable: false));
  }
}
