import 'dartTest.dart';


var testString = "this"
                "is"
                "test string";

var testStr = "this is ${testString.toUpperCase()} test";

var str = """this is String \\ "" ''
            this is String""";
var rawStr = r'"test /\n ${/''}"';

main() {
  Object name = 1;
  dynamic dynamics = "DateTime";
  // 编译时没错，但是运行时就会出错了
  // dynamics++;
  // print(convertToBool(name));
  // print(convertToBool2(name));
  // print(dynamics.toString());
  var test = rawStr;
  print(rawStr);
}

bool convertToBool(dynamic arg) {
  if (arg is bool) return arg;
  if (arg is String) return arg == 'true';
  throw ArgumentError('Cannot convert $arg to a bool.');
}

bool convertToBool2(Object arg) {
  if (arg is bool) return arg;
  if (arg is String) return arg == 'true';
  throw ArgumentError('Cannot convert ${arg.toString()} to a bool.');
}