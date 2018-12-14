
import 'package:meta/meta.dart';
import './dartTest.dart';

main(List<String> args) {

  print(loudify("Test"));

  var testList = [1,2,3,4];

  // 匿名函数
  testList.forEach((item){
      //do Something
  });

  var madd = makeAdder(1);
  print(madd(1));

}

/**
 * 返回一个 函数 (num i) => addBy + i
 */
Function makeAdder(num addBy) {
  // return (num i) => addBy + i;
  return (num i){
      return addBy + i;
  };
}



// 函数作为字段
var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';

/**
 * 参数测试
 */
prarmsTest(){
  enableFlags(hidden:false,bold:true);
  testRequired(name:"maintel");
  testRequired2("maintel", 10);
  testRequired();

  // doStuff();
  var testList = [1,2,2,3,4];
  doStuff(list:testList);
  print("testList:: $testList");// 此时数据被修改
  var intTest = 100;
  doTest(intTest);  // 此时数据不会被修改
  print(intTest);
}


doTest(int a){
  a = a+10;
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
 * 在指定参数名时可以使用使用 required 来标识当前参数是必须的（不过需要注
 * 的是，即使标注了是必须的参数也在不传的情况下编译器也只是会报警告而不是报错）
 * 
 * @required 包含在 meta 库中，在 dart 需要引入`package:meta/meta.dart`
 * 在 fluter 中需要引入 `package:flutter/material.dart`
 * 
 * 同时也可以指定默认值，比如下面的 name 参数
 * 当参数名被指定的时候，任何参数都能指定默认值
 * 
 */
testRequired({String name = "laowang", @required int age}){
  print("name::$name   age::$age");
}

/**
 * 使用 {} 包裹的参数在调用的时候必须指定参数名，但是可以不用关心参数的顺序:
 * 比如 testRequired 的调用
 * testRequired(age:100,name:"maintel");
 * 下面使用 [] 包裹的参数在调用时也是可以忽略的，但是必须按照顺序调用，不能指定参数名
 * 比如 testRequired2 调用
 * testRequired2("name name",10,"test");
 * 
 * 可选参数可以在调用的时候只传递其中的某一个值：
 * testRequired(age:100)
 */

/**
 * 不使用指定参数名时，
 * 也可以使用 `[]` 来标记一个参数是可选的，但是这个时候就不能放到 `{}` 中了
 * 
 * 如果不指定参数名的时候，只有在 `[]` 或者 `{}` 即可选参数的时候给指定默认值，比如下面的 interests 参数
 */
testRequired2(String name, [int age, String interests = "book"]){
  print("name::$name   age::$age");
}

/**
 * 默认参数支持很多类型，如果是一个 lsit 或者 map 必须指定成 cosnt 的。
 * 这个时候需要注意的是，const 型的实例是不能被修改的，所以使用时涉及到修改时需要谨慎
 * doStuff();   这样调用报错运行会报错
 * doStuff(list:[3,6,9]); 这样不会报错
 */
doStuff({
  List<int> list = const [1,2,3]
}){
  list[1] = 10;
  print("list:: $list");
}

