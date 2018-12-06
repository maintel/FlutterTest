import 'dartTest.dart';

main() {
  Object name = 1;
  dynamic dynamics = "DateTime";
  // 编译时没错，但是运行时就会出错了
  // dynamics++;
  print(convertToBool(name));
  print(convertToBool2(name));
  print(dynamics.toString());

}

bool convertToBool(dynamic arg) {
  if (arg is bool) return arg;
  if (arg is String) return arg == 'true';
  throw ArgumentError('Cannot convert $arg to a bool.');
}

bool convertToBool2(Object arg) {
  if (arg is bool) return arg;
  if (arg is String) return arg == 'true';
  throw ArgumentError('Cannot convert $arg to a bool.');
}