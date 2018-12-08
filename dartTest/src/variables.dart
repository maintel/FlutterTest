
final String topLevelFianl = "topLevelFianl";
// 如果是顶级变量，则不用加 static
const constTest = "adadad";

const age = 10;
const newAge = age * 10;

main() {
  // print(VariableTest().toString());
  var variableTest = VariableTest();
  variableTest._name = "wangmeimei";
  // final 不能被修改
  // variableTest.finalTest = "wangmeimei";
  print(variableTest.toString());
  print(topLevelFianl);
  final tempStr = "adad";


  var foo = const [1,2,3,4,5,6,7,8];
  // 即使用 cosnt 初始化了一个变量，它一样可以被重新赋值
  //   foo[1] = 10;   但是不能被修改
  foo = [1,2,3,4];
  foo = [4,5,6,7,5];
  foo[1] = 10; // 被重新赋值以后 就可以被修改了
  print(foo);
  // double 支持使用科学计数法
  print(1.42e5);

  var constList = const [1,2,3];
  constList[1] = 10;

}





class VariableTest {
  var _name = "maintel";

  // 初始值为 null 而不是 0
  int age;


  //final 在他第一次被调用的时候初始化
  final finalTest = "final";
  // 也可以指定类型
  final String finalString = "final";

  // 如果是类级别的 const 则需要加上 static
  static const constTest = "adadad";


  setName(String name){
    this._name = name;
  }


  @override
    String toString() {
      // TODO: implement toString
      return "name::$_name\nage::$age";
    }

}


