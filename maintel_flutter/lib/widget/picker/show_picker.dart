import 'package:flutter/material.dart';
import 'package:maintel_flutter/utils/data_utils.dart';
import 'package:maintel_flutter/widget/picker/popu_route.dart';
import 'package:maintel_flutter/widget/picker/result.dart';
import 'package:maintel_flutter/widget/picker/time_picker/my_time_picker_widget.dart';

import 'list_picker/list_picker.dart';

Future<PickerResult> showListPicker(BuildContext context, List list) {
  return Navigator.of(context, rootNavigator: true).push(CommonButtonPopuRoute(
    child: ListPicker(list),
  ));
}

Future<TimePickerResult> showMyTimePicker(
  BuildContext context, {
  TimePiclerType model = TimePiclerType.YearMonthDay,
  List<String> dateFormat= DATE_FORMAT_DATE_TIME,
  DateTime startTime,
  DateTime endTime,
  DateTime currentTime,
}) {
  return Navigator.of(context, rootNavigator: true).push(CommonButtonPopuRoute(
    child: MyTimePicker(),
  ));
}
