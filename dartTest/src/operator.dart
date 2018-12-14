main(List<String> args) {
  num a = 1;
  print('5/2 = ${5 ~/ 2} r ${5 % 2}' == '5/2 = 2 r 1');

  print("${5 ~/ 2}");  // 2
  print("${5 / 2}");  // 2.5
  print("${5 % 2}");  // 1

  var b = 10;
  b ??= 100;
  print(b);
  var c;
  c ??= 100;
  print(c);


  var boolean = "string";

  print(boolean ?? "test");

  // .. 是级联操作符，有点像 react 中的级联操作符
  // 它和 java 的链式编程是有区别的，它对当前这个对象起作用。比如下面这样
  var test = Test() // 初始化一个对象 test
              ..name = "test" // 设置name 为 test
              ..age = 10  //设置 age 为 10
              ..hello() // 调用了一下 hello 函数
              ..getName() // 调用了一下 getName 函数
              ..name = "maintel"; // 设置了 name 为 maintel

  test.hello();

}


/**
 * `==` 操作符，其实是一个方法，甚至可以被重写
 * 当使用它的时候其实是调用了`x==y` 其实就是 `x.==(y)`
 */

class Test{
  var name;

  var age = 0;

  void hello(){
    print("name::$name  age::$age");
  }

  String getName(){
    return name;
  }

}


String test(String str){
  return str + "::";
}