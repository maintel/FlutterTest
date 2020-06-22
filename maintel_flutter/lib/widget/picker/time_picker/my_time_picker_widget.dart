import 'package:flutter/material.dart';
import 'package:maintel_flutter/utils/data_utils.dart';
import 'package:maintel_flutter/widget/picker/list_picker/list_picker_wheel.dart';

/// 有六种种格式
/// - HourMin 时：分
/// - HourMinSec 时：分：秒
/// - MonthDay 月：日
/// - YearMoth 年：月
/// - YearMothDay 年：月：日
/// - YearMothDayHourMin 年：月：日：时：分
/// - All 年：月：日：时：分：秒
enum TimePiclerType {
  HourMin,
  HourMinSec,
  MonthDay,
  YearMoth,
  YearMothDay,
  YearMothDayHourMin,
  All,
}

const int _defaultStartYear = 1970;
const int _defaultEndYear = 2050;

///  日期选择器
class MyTimePicker extends StatefulWidget {
  TimePiclerType model;
  List<String> dateFormat;

  DateTime startTime;
  DateTime endTime;
  DateTime currentTime;

  MyTimePicker(
      {this.model = TimePiclerType.YearMothDay,
      this.startTime,
      this.endTime,
      this.currentTime,
      this.dateFormat = DATE_FORMAT_DATE_TIME}) {
    if (startTime == null) {
      startTime = DateTime(_defaultStartYear);
    }
    if (endTime == null) {
      endTime = DateTime(_defaultEndYear, 12, 31);
    }
    if (currentTime == null) {
      currentTime = DateTime.now();
    }

    if (startTime.isAfter(endTime)) {
      throw "开始时间不能晚于结束时间";
    }

    if (currentTime.isBefore(startTime)) {
      currentTime = startTime;
    }
    if (currentTime.isAfter(endTime)) {
      currentTime = endTime;
    }
  }

  @override
  State<StatefulWidget> createState() {
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

  int _mothDay; // 某月当中有多少天
  int _yearMonth; // 一年当中有多少个月
  int _currentYearStartMonth;

  @override
  void initState() {
    super.initState();
    _selectYear = widget.currentTime.year;
    _selectMonth = widget.currentTime.month;
    _selectDay = widget.currentTime.day;
    _selectHour = widget.currentTime.hour;
    _selectMin = widget.currentTime.minute;
    _selectSecond = widget.currentTime.second;
    _mothDay = getDaysInMonth(_selectYear, _selectMonth);
    _currentYearStartMonth = _startMonth();
    _yearMonth = 13 - _currentYearStartMonth;
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

  /// 年选择
  _buildYearWheel() {
    return MyCupertinoPicker(
        onSelectedItemChanged: (value) => _selectYearChange(value),
        scrollController: FixedExtentScrollController(
            initialItem: _selectYear - widget.endTime.year),
        children: List<Widget>.generate(
            (widget.endTime.year - widget.startTime.year + 1), (index) {
          return Text("${widget.endTime.year - index}年");
        }));
  }

  /// 月份选择
  _buildMonthWheel() {
    return MyCupertinoPicker(
        key: Key("$_selectYear"),
        onSelectedItemChanged: (value) => _selectMothChange(value),
        scrollController:
            FixedExtentScrollController(initialItem: _initialMonthIndex()),
        children: List<Widget>.generate(_yearMonth, (index) {
          return Text("${index + _currentYearStartMonth}月");
        }));
  }

  /// 天选择
  _buildDayWheel() {
    return MyCupertinoPicker(
        key: Key("$_selectMonth"),
        scrollController:
            FixedExtentScrollController(initialItem: _selectDay - 1),
        children: List<Widget>.generate(_mothDay, (index) {
          return Text("${index + 1}日");
        }));
  }

  /// 月份变化，这个时候要更新天选择器，
  _selectMothChange(int monthIndex) {
    setState(() {
      _selectMonth = _currentYearStartMonth + monthIndex;
      _mothDay = getDaysInMonth(_selectYear, _selectMonth);
    });
  }

  _selectYearChange(int year) {
    setState(() {
      _selectYear = widget.endTime.year - year;
      _currentYearStartMonth = _startMonth();
      _yearMonth = 13 - _currentYearStartMonth;
    });
  }

  _initialMonthIndex() {
    if (_selectMonth - _currentYearStartMonth < 0) {
      _selectMonth = _currentYearStartMonth;
      return 0;
    }
    return _selectMonth - _currentYearStartMonth;
  }

  _startMonth() {
    if (_selectYear == widget.endTime.year) {
      return widget.endTime.month;
    } else if (_selectYear == widget.startTime.year) {
      return widget.startTime.month;
    } else {
      return 1;
    }
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
