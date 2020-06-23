import 'package:flutter/material.dart';
import 'package:maintel_flutter/utils/data_utils.dart';
import 'package:maintel_flutter/widget/picker/common_wdiget.dart';
import 'package:maintel_flutter/widget/picker/list_picker/list_picker_wheel.dart';
import 'package:maintel_flutter/widget/picker/popu_route.dart';
import 'package:maintel_flutter/widget/picker/result.dart';

/// 有六种种格式
/// - HourMin 时：分
/// - HourMinSec 时：分：秒
/// - MonthDay 月：日
/// - YearMonth 年：月
/// - YearMonthDay 年：月：日
/// - YearMonthDayHourMin 年：月：日：时：分
/// - All 年：月：日：时：分：秒
enum TimePiclerType {
  HourMin,
  HourMinSec,
  MonthDay,
  YearMonth,
  YearMonthDay,
  YearMonthDayHourMin,
  All,
}

const int _defaultStartYear = 1970;
const int _defaultEndYear = 2050;
const Color _defaultPostiveTextColor = Color(0xffFF7459);
const Color _defaultNegativeTextColor = Color(0xff9C9C9C);

///  日期选择器
class MyTimePicker extends StatefulWidget {
  TimePiclerType model;
  List<String> dateFormat;

  DateTime startTime;
  DateTime endTime;
  DateTime currentTime;

  Color backgroundColor;
  double height;

  final Color positiveTextColor;
  final Color negativeTextColor;
  final String positiveText;
  final String negativeText;

  MyTimePicker(
      {this.model = TimePiclerType.YearMonthDay,
      this.positiveText = "完成",
      this.negativeText = "取消",
      this.positiveTextColor = _defaultPostiveTextColor,
      this.negativeTextColor = _defaultNegativeTextColor,
      this.startTime,
      this.endTime,
      this.currentTime,
      this.height = 300,
      this.backgroundColor = Colors.white,
      this.dateFormat = DEFAULT_TIME_FORMAT}) {
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

  int _monthDay; // 某月当中有多少天
  int _yearMonth; // 一年当中有多少个月
  int _currentYearStartMonth;
  int _currentMonthStart; // 某月的起始日期
  int _monthPickerInitial;

  int _minIndex;
  int _currentMinTotal;

  @override
  void initState() {
    super.initState();
    _selectYear = widget.currentTime.year;
    _selectMonth = widget.currentTime.month;
    _selectDay = widget.currentTime.day;
    _selectHour = widget.currentTime.hour;
    _selectMin = widget.currentTime.minute;
    _initialMin();
    _selectSecond = widget.currentTime.second;
    // _monthDay = getDaysInMonth(_selectYear, _selectMonth);
    _initialDayInMonth();
    _currentYearStartMonth = _startMonth();
    _monthPickerInitial = _initialMonthIndex();
    print("currentTime::${widget.currentTime}");
  }

  /// 小时选择
  _buildHourWheel(PickerLightType type) {
    return MyCupertinoPicker(
        lightBgType: type,
        onSelectedItemChanged: (value) => _selectHourChange(value),
        scrollController: FixedExtentScrollController(
            initialItem: _selectHour - widget.startTime.hour),
        children: List<Widget>.generate(_initHourList(), (index) {
          return Text("${index + widget.startTime.hour}时");
        }));
  }

  _selectHourChange(int index) {
    setState(() {
      _selectHour = index + widget.startTime.hour;
      _initialMin();
    });
  }

  _initHourList() {
    var hours = widget.endTime.hour - widget.startTime.hour + 1;
    if (hours == 1) {
      hours = 24;
    }
    return hours;
  }

  /// 分钟选择
  _buildMinWheel(PickerLightType type) {
    return MyCupertinoPicker(
        key: Key("$_selectHour"),
        lightBgType: type,
        onSelectedItemChanged: (value) => _selectMinChange(value),
        scrollController: FixedExtentScrollController(initialItem: _minIndex),
        children: List<Widget>.generate(_currentMinTotal, (index) {
          return Text("${_minItem(index)}分");
        }));
  }

  _selectMinChange(int index) {
    if (_selectHour == widget.endTime.hour) {
      _selectMin = index;
    } else {
      _selectMin = index + 60 - _currentMinTotal;
    }
  }

  _minItem(int index) {
    if (_selectHour == widget.endTime.hour) {
      return index;
    }
    return 60 - _currentMinTotal + index;
  }

  _initialMin() {
    _currentMinTotal = 60;
    if (_selectHour == widget.startTime.hour) {
      if (_selectMin < widget.startTime.minute) {
        _selectMin = widget.startTime.minute;
      }
      _currentMinTotal = 60 - widget.startTime.minute;
      _minIndex = _selectMin - widget.startTime.minute;
    } else if (_selectHour == widget.endTime.hour) {
      if (_selectMin > widget.endTime.minute) {
        _selectMin = widget.endTime.minute;
      }
      _currentMinTotal = widget.endTime.minute + 1;
      _minIndex = _selectMin;
    } else {
      _minIndex = _selectMin;
    }
  }

  /// 秒选择
  _buildSecWheel(PickerLightType type) {
    return MyCupertinoPicker(
        lightBgType: type,
        onSelectedItemChanged: (value) => {},
        scrollController:
            FixedExtentScrollController(initialItem: _selectSecond),
        children: List<Widget>.generate(60, (index) {
          return Text("$index秒");
        }));
  }

  /// 年选择
  _buildYearWheel(PickerLightType type) {
    return MyCupertinoPicker(
        lightBgType: type,
        onSelectedItemChanged: (value) => _selectYearChange(value),
        scrollController: FixedExtentScrollController(
            initialItem: _selectYear - widget.startTime.year),
        children: List<Widget>.generate(
            (widget.endTime.year - widget.startTime.year + 1), (index) {
          return Text("${widget.startTime.year + index}年");
        }));
  }

  /// 月份选择
  _buildMonthWheel(PickerLightType type) {
    return MyCupertinoPicker(
        lightBgType: type,
        key: Key("$_selectYear"),
        onSelectedItemChanged: (value) => _selectmonthChange(value),
        scrollController:
            FixedExtentScrollController(initialItem: _monthPickerInitial),
        children: List<Widget>.generate(_yearMonth, (index) {
          return Text("${index + _currentYearStartMonth}月");
        }));
  }

  /// 天选择
  _buildDayWheel(PickerLightType type) {
    return MyCupertinoPicker(
        lightBgType: type,
        onSelectedItemChanged: (value) => _selectDayChange(value),
        key: Key("$_selectMonth$_selectYear"),
        scrollController: FixedExtentScrollController(
            initialItem: _selectDay - _currentMonthStart),
        children: List<Widget>.generate(_monthDay, (index) {
          return Text("${index + _currentMonthStart}日");
        }));
  }

  _selectDayChange(int index) {
    setState(() {
      _selectDay = index + _currentMonthStart;
    });
  }

  /// 月份变化，这个时候要更新天选择器，
  _selectmonthChange(int monthIndex) {
    setState(() {
      _selectMonth = _currentYearStartMonth + monthIndex;
      _initialDayInMonth();
      if (_selectDay > _monthDay + _currentMonthStart) {
        _selectDay = _monthDay + _currentMonthStart;
      } else if (_selectDay < _currentMonthStart) {
        _selectDay = _currentMonthStart;
      }
    });
  }

  /// 某月中有多少天 因为可能存在起始结束日期不在月末
  _initialDayInMonth() {
    if (_selectMonth == widget.startTime.month &&
        _selectYear == widget.startTime.year) {
      _monthDay =
          getDaysInMonth(_selectYear, _selectMonth) - widget.startTime.day + 1;
      _currentMonthStart = widget.startTime.day;
    } else if (_selectMonth == widget.endTime.month &&
        _selectYear == widget.endTime.year) {
      _monthDay = widget.startTime.day;
      _currentMonthStart = 1;
    } else {
      _monthDay = getDaysInMonth(_selectYear, _selectMonth);
      _currentMonthStart = 1;
    }
  }

  _selectYearChange(int index) {
    setState(() {
      _selectYear = widget.startTime.year + index;
      _currentYearStartMonth = _startMonth();
      _monthPickerInitial = _initialMonthIndex();
      _initialDayInMonth();
      if (_selectDay > _monthDay + _currentMonthStart) {
        _selectDay = _monthDay + _currentMonthStart;
      } else if (_selectDay < _currentMonthStart) {
        _selectDay = _currentMonthStart;
      }
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
      _yearMonth = widget.endTime.month;
      return 1;
    } else if (_selectYear == widget.startTime.year) {
      _yearMonth = 13 - widget.startTime.month;
      return widget.startTime.month;
    } else {
      _yearMonth = 12;
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> timeWheels = List<Widget>();
    switch (widget.model) {
      case TimePiclerType.HourMin:
        timeWheels.add(_buildHourWheel(PickerLightType.LeftRadius));
        timeWheels.add(_buildMinWheel(PickerLightType.RightRadius));
        break;
      case TimePiclerType.HourMinSec:
        timeWheels.add(_buildHourWheel(PickerLightType.LeftRadius));
        timeWheels.add(_buildMinWheel(PickerLightType.None));
        timeWheels.add(_buildSecWheel(PickerLightType.RightRadius));
        break;
      case TimePiclerType.MonthDay:
        timeWheels.add(_buildMonthWheel(PickerLightType.LeftRadius));
        timeWheels.add(_buildDayWheel(PickerLightType.RightRadius));
        break;
      case TimePiclerType.YearMonth:
        timeWheels.add(_buildYearWheel(PickerLightType.LeftRadius));
        timeWheels.add(_buildMonthWheel(PickerLightType.RightRadius));
        break;
      case TimePiclerType.YearMonthDay:
        timeWheels.add(_buildYearWheel(PickerLightType.LeftRadius));
        timeWheels.add(_buildMonthWheel(PickerLightType.None));
        timeWheels.add(_buildDayWheel(PickerLightType.RightRadius));
        break;
      case TimePiclerType.YearMonthDayHourMin:
        timeWheels.add(_buildYearWheel(PickerLightType.LeftRadius));
        timeWheels.add(_buildMonthWheel(PickerLightType.None));
        timeWheels.add(_buildDayWheel(PickerLightType.None));
        timeWheels.add(_buildHourWheel(PickerLightType.None));
        timeWheels.add(_buildMinWheel(PickerLightType.RightRadius));
        break;
      case TimePiclerType.All:
        timeWheels.add(_buildYearWheel(PickerLightType.LeftRadius));
        timeWheels.add(_buildMonthWheel(PickerLightType.None));
        timeWheels.add(_buildDayWheel(PickerLightType.None));
        timeWheels.add(_buildHourWheel(PickerLightType.None));
        timeWheels.add(_buildMinWheel(PickerLightType.None));
        timeWheels.add(_buildSecWheel(PickerLightType.RightRadius));
        break;
      default:
        timeWheels.add(_buildYearWheel(PickerLightType.LeftRadius));
        timeWheels.add(_buildMonthWheel(PickerLightType.None));
        timeWheels.add(_buildDayWheel(PickerLightType.RightRadius));
    }
    final route = InheritRouteWidget.of(context).router;
    return AnimatedBuilder(
        animation: route.animation,
        builder: (BuildContext context, Widget child) {
          return CustomSingleChildLayout(
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                child: Container(
                  padding:
                      EdgeInsets.only(top: 16, left: 15, right: 15, bottom: 20),
                  height: widget.height,
                  color: widget.backgroundColor,
                  child: Column(
                    children: <Widget>[
                      _getTitleWidget(),
                      Container(
                        margin: EdgeInsets.only(top: 14, bottom: 16.5),
                        height: 1,
                        color: Color(0xffEEEEEE),
                      ),
                      Expanded(
                        child: Row(
                            children: timeWheels
                                .map((item) => Expanded(
                                      child: item,
                                    ))
                                .toList(growable: false)),
                        flex: 1,
                      )
                    ],
                  ),
                )),
            delegate: WrapLayout(progress: route.animation.value, height: 400),
          );
        });
  }

  Widget _getTitleWidget() {
    return PickerTitleWidget(() {
      Navigator.pop(context);
    }, () {
      var date = DateTime(_selectYear, _selectMonth, _selectDay, _selectHour,
          _selectMin, _selectMin);
      var dateString = formatDate(date, widget.dateFormat);
      var result = TimePickerResult(dateString, date);
      Navigator.pop(context, result);
    }, widget.negativeText, widget.negativeTextColor, widget.positiveText,
        widget.positiveTextColor);
  }
}
