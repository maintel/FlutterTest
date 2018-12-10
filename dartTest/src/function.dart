
import 'package:meta/meta.dart';
import './dartTest.dart';

main(List<String> args) {
  enableFlags(hidden:false,bold:true);

  testRequired(name:"maintel");
  testRequired2("maintel", 10);
  testRequired();
}

/**
 * 指定参数名，这样在调用的时候不用关注顺序，但是必须指定参数名。
  enableFlags(hidden:false,bold:true);
 * 
 * 使用指定参数名，可以在复杂函数下使代码更易读
 * 
 */
enableFlags({bool bold, bool hidden}){
  print("bold::$bold  hidden::$hidden");
}

/**
 * 在指定参数名时可以使用使用 required 来标识当前参数是可选的
 * 
 * @required 包含在 meta 库中，在 dart 需要引入`package:meta/meta.dart`
 * 在 fluter 中需要引入 `package:flutter/material.dart`
 * 
 * 同时也可以指定默认值，当指定默认值的时候，这个参数一样可以不传  testRequired();
 * 当参数名被指定的时候，任何参数都能指定默认值
 * 
 */
testRequired({String name = "laowang", @required int age}){
  print("name::$name   age::$age");
}

/**
 * 不使用指定参数名时，
 * 也可以使用 `[]` 来标记一个参数是可选的，但是这个时候就不能放到 `{}` 中了
 * 
 * 如果不指定参数名的时候，只有在 `[]` 即可选参数的时候给指定默认值，比如下面的 interests 参数
 */
testRequired2(String name, [int age, String interests = "book"]){
  print("name::$name   age::$age");
}



