void main() {
  var one = int.parse("10");
  // 如果不是整数则会报错
  // var one = int.parse("10.1");
  print(one);
  var oneString = 1.toString();
  print(oneString == "1");
  // 保留几位小数
  var pi = 3.1415926.toStringAsFixed(2);
  // 显示成几位的科学计数法 比如 1234567.toStringAsPrecision(3); // 1.23e+6
  // 此时 pi2 ==> 3.1
  var pi2 = 3.1415926.toStringAsPrecision(2);
  print(pi);
  print(pi2);
}