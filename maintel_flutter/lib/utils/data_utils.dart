/// Outputs year as four digits
///
/// Example:
///     formatDate(DateTime(1989), [yyyy]);
///     // => 1989
const String yyyy = 'yyyy';

/// Outputs year as two digits
///
/// Example:
///     formatDate(DateTime(1989), [yy]);
///     // => 89
const String yy = 'yy';

/// Outputs month as two digits
///
/// Example:
///     formatDate(DateTime(1989, 11), [mm]);
///     // => 11
///     formatDate(DateTime(1989, 5), [mm]);
///     // => 05
const String MM = 'MM';

/// Outputs month compactly
///
/// Example:
///     formatDate(DateTime(1989, 11), [mm]);
///     // => 11
///     formatDate(DateTime(1989, 5), [m]);
///     // => 5
const String M = 'M';

/// Outputs month as long name
///
/// Example:
///     formatDate(DateTime(1989, 2), [MM]);
///     // => 二月
const String MMC = 'MMC';

/// Outputs month as short name
///
/// Example:
///     formatDate(DateTime(1989, 2), [M]);
///     // => feb
const String MC = 'MC';

/// Outputs day as two digits
///
/// Example:
///     formatDate(DateTime(1989, 2, 21), [dd]);
///     // => 21
///     formatDate(DateTime(1989, 2, 5), [dd]);
///     // => 05
const String dd = 'dd';

/// Outputs day compactly
///
/// Example:
///     formatDate(DateTime(1989, 2, 21), [d]);
///     // => 21
///     formatDate(DateTime(1989, 2, 5), [d]);
///     // => 5
const String d = 'd';

/// Outputs week in month
///
/// Example:
///     formatDate(DateTime(1989, 2, 21), [w]);
///     // => 4
const String w = 'w';

/// Outputs week in year as two digits
///
/// Example:
///     formatDate(DateTime(1989, 12, 31), [W]);
///     // => 53
///     formatDate(DateTime(1989, 2, 21), [W]);
///     // => 08
const String WW = 'WW';

/// Outputs week in year compactly
///
/// Example:
///     formatDate(DateTime(1989, 2, 21), [W]);
///     // => 8
const String W = 'W';

/// Outputs week day as long name
///
/// Example:
///     formatDate(DateTime(2018, 1, 14), [DD]);
///     // => sunday
const String DD = 'DD';

/// Outputs week day as long name
///
/// Example:
///     formatDate(DateTime(2018, 1, 14), [D]);
///     // => sun
const String D = 'D';

/// Outputs hour (0 - 11) as two digits
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15), [hh]);
///     // => 03
const String hh = 'hh';

/// Outputs hour (0 - 11) compactly
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15), [h]);
///     // => 3
const String h = 'h';

/// Outputs hour (0 to 23) as two digits
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15), [HH]);
///     // => 15
const String HH = 'HH';

/// Outputs hour (0 to 23) compactly
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 5), [H]);
///     // => 5
const String H = 'H';

/// Outputs minute as two digits
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15, 40), [nn]);
///     // => 40
///     formatDate(DateTime(1989, 02, 1, 15, 4), [nn]);
///     // => 04
const String mm = 'mm';

/// Outputs minute compactly
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15, 4), [n]);
///     // => 4
const String m = 'm';

/// Outputs second as two digits
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10), [ss]);
///     // => 10
///     formatDate(DateTime(1989, 02, 1, 15, 40, 5), [ss]);
///     // => 05
const String ss = 'ss';

/// Outputs second compactly
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15, 40, 5), [s]);
///     // => 5
const String s = 's';

/// Outputs millisecond as three digits
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 999), [SSS]);
///     // => 999
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 99), [SS]);
///     // => 099
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 0), [SS]);
///     // => 009
const String SSS = 'SSS';

/// Outputs millisecond compactly
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 999), [SSS]);
///     // => 999
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 99), [SS]);
///     // => 99
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 9), [SS]);
///     // => 9
const String S = 'S';

/// Outputs microsecond as three digits
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 0, 999), [uuu]);
///     // => 999
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 0, 99), [uuu]);
///     // => 099
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 0, 9), [uuu]);
///     // => 009
const String uuu = 'uuu';

/// Outputs millisecond compactly
///
/// Example:
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 0, 999), [u]);
///     // => 999
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 0, 99), [u]);
///     // => 99
///     formatDate(DateTime(1989, 02, 1, 15, 40, 10, 0, 9), [u]);
///     // => 9
const String u = 'u';

/// Outputs if hour is AM or PM
///
/// Example:
///     print(formatDate(DateTime(1989, 02, 1, 5), [am]));
///     // => 上午
///     print(formatDate(DateTime(1989, 02, 1, 15), [am]));
///     // => 下午
const String am = 'am';

/// Outputs timezone as time offset
///
/// Example:
///
const String z = 'z';
const String Z = 'Z';

// 短日期格式
const List<String> DATE_FORMAT = [yyyy, "-", MM, "-", dd];
const List<String> DATE_FORMAT1 = [yyyy, "/", MM, "/", dd];
const List<String> DATE_FORMAT_DATE_TIME = [
  yyyy,
  "/",
  MM,
  "/",
  dd,
  " ",
  HH,
  ":",
  mm
];

// 长日期格式
const List<String> MONTH_FORMAT = [MM, "月", dd, "日"];
const List<String> MONTH_DAY_FORMAT = [MM, "-", dd];
const List<String> DEFAULT_TIME_HOUR_FORMAT = [HH, ":", mm];
// 长日期格式
const List<String> DEFAULT_TIME_FORMAT = [
  yyyy,
  "-",
  MM,
  "-",
  dd,
  " ",
  HH,
  ":",
  mm,
  ":",
  ss
];
const List<String> DEFAULT_TIME_FORMAT_FRZ = [HH, ":", mm, ":", ss];
const List<String> DEFAULT_TIME_FORMAT_TIME = [MM, "-", dd, " ", HH, ":", mm];
const List<String> DATE_TIME_FORMAT_TIME = [
  yyyy,
  "-",
  MM,
  "-",
  dd,
  " ",
  HH,
  ":",
  mm
];
const List<String> DEFAULT_TIME_FORMAT_MIN = [
  yyyy,
  "-",
  MM,
  "-",
  dd,
  " ",
  HH,
  ":",
  mm
];

String formatDate(DateTime date, List<String> formats) {
  final sb = StringBuffer();

  for (String format in formats) {
    if (format == yyyy) {
      sb.write(_digits(date.year, 4));
    } else if (format == yy) {
      sb.write(_digits(date.year % 100, 2));
    } else if (format == MM) {
      sb.write(_digits(date.month, 2));
    } else if (format == M) {
      sb.write(date.month);
    } else if (format == MMC) {
      sb.write(monthsLong[date.month - 1]);
    } else if (format == MC) {
      sb.write(monthsShort[date.month - 1]);
    } else if (format == dd) {
      sb.write(_digits(date.day, 2));
    } else if (format == d) {
      sb.write(date.day);
    } else if (format == w) {
      sb.write((date.day + 7) ~/ 7);
    } else if (format == W) {
      sb.write((dayInYear(date) + 7) ~/ 7);
    } else if (format == WW) {
      sb.write(_digits((dayInYear(date) + 7) ~/ 7, 2));
    } else if (format == DD) {
      sb.write(daysLong[date.weekday - 1]);
    } else if (format == D) {
      sb.write(daysShort[date.weekday - 1]);
    } else if (format == HH) {
      sb.write(_digits(date.hour, 2));
    } else if (format == H) {
      sb.write(date.hour);
    } else if (format == hh) {
      int hour = date.hour % 12;
      if (hour == 0) hour = 12;
      sb.write(_digits(hour, 2));
    } else if (format == h) {
      int hour = date.hour % 12;
      if (hour == 0) hour = 12;
      sb.write(hour);
    } else if (format == am) {
      sb.write(date.hour < 12 ? '上午' : '下午');
    } else if (format == mm) {
      sb.write(_digits(date.minute, 2));
    } else if (format == m) {
      sb.write(date.minute);
    } else if (format == ss) {
      sb.write(_digits(date.second, 2));
    } else if (format == s) {
      sb.write(date.second);
    } else if (format == SSS) {
      sb.write(_digits(date.millisecond, 3));
    } else if (format == S) {
      sb.write(date.second);
    } else if (format == uuu) {
      sb.write(_digits(date.microsecond, 2));
    } else if (format == u) {
      sb.write(date.microsecond);
    } else if (format == z) {
      if (date.timeZoneOffset.inMinutes == 0) {
        sb.write('Z');
      } else {
        if (date.timeZoneOffset.isNegative) {
          sb.write('-');
          sb.write(_digits((-date.timeZoneOffset.inHours) % 24, 2));
          sb.write(_digits((-date.timeZoneOffset.inMinutes) % 60, 2));
        } else {
          sb.write('+');
          sb.write(_digits(date.timeZoneOffset.inHours % 24, 2));
          sb.write(_digits(date.timeZoneOffset.inMinutes % 60, 2));
        }
      }
    } else if (format == Z) {
      sb.write(date.timeZoneName);
    } else {
      sb.write(format);
    }
  }

  return sb.toString();
}

String _digits(int value, int length) {
  String ret = '$value';
  if (ret.length < length) {
    ret = '0' * (length - ret.length) + ret;
  }
  return ret;
}

int dayInYear(DateTime date) =>
    date.difference(DateTime(date.year, 1, 1)).inDays;

final List<String> monthsShort = const [
  '一月',
  '二月',
  '三月',
  '四月',
  '五月',
  '六月',
  '七月',
  '八月',
  '九月',
  '十月',
  '十一月',
  '十二月'
];

final List<String> monthsLong = const [
  '一月',
  '二月',
  '三月',
  '四月',
  '五月',
  '六月',
  '七月',
  '八月',
  '九月',
  '十月',
  '十一月',
  '十二月'
];

final List<String> daysShort = const [
  '星期一',
  '星期二',
  '星期三',
  '星期四',
  '星期五',
  '星期六',
  '星期日'
];

final List<String> daysLong = const [
  '星期一',
  '星期二',
  '星期三',
  '星期四',
  '星期五',
  '星期六',
  '星期日'
];

// 某月有多少天
const List<int> _daysInMonth = <int>[
  31,
  -1,
  31,
  30,
  31,
  30,
  31,
  31,
  30,
  31,
  30,
  31
];

/// 获取某月中有多少天
int getDaysInMonth(int year, int month) {
  if (month == DateTime.february) {
    final bool isLeapYear =
        (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
    if (isLeapYear) return 29;
    return 28;
  }
  return _daysInMonth[month - 1];
}
