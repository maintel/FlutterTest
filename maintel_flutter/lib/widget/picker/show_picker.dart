import 'package:flutter/material.dart';
import 'package:maintel_flutter/widget/picker/popu_route.dart';

import 'list_picker/list_picker.dart';
import 'list_picker/list_result.dart';

Future<PickerResult> showListPicker(BuildContext context,List list) {
  return Navigator.of(context, rootNavigator: true).push(CommonButtonPopuRoute(
    child: ListPicker(list),
  ));
}

void test(dynamic value) {}
