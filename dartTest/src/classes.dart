import "package:meta/meta.dart";

main(List<String> args) {
  
  var test = Test();
  test.name = "maintel";
  test.age = 10;
  var test3 = Test3.newInstance("name", 100);
 var emp = new Employee.fromJson({});
  // Prints:
  // in Person
  // in Employee
  if (emp is Person) {
    // Type check
    emp.firstName = 'Bob';
  }

  if(emp is Employee) {
    emp.firstName = "test";
  }
  print(emp.firstName);


  var initializerTest = InitializerTest(0, 100);
  initializerTest.printMe();
  var initializerTest2 = InitializerTest.newInstance(100);
  initializerTest2.printMe();

  var testConst = const TestCosnt("testConst");
  
  print(testConst.data);
  print(testConst.name);

  var testConst2  = const TestCosnt("testConst 2222");
  var testConst3  = const TestCosnt("testConst");

  print(testConst2.data);
  print(testConst2.name);
  print(testConst2.age);

  print(testConst == testConst2);  // false
  print(testConst == testConst3);  // true
  print(identical(testConst, testConst3));

  Logger._internal("test").log("msg");
  // 直接走的 factory 构造函数
  Logger("name").log("teaadad");


  // var abstracts = AbstractContainer();
  var abstracts = AbstractFactoryClass();

  // abstracts.log(); // 运行报错

  print(SingleClass() == SingleClass());
  print(identical(SingleClass(),SingleClass()));

}

// 抽象类不能被实例化
abstract class AbstractContainer {
  // Define constructors, fields, methods...

  void updateChildren(); // Abstract method.
  void log(){
    print("this is abstract class");
  }
}

// 给了一个 factory 看起来是可以被实例化了，然而没有任何卵用
// 更坑爹的是，这个时候子类继承它也会出错，因为它是一个 factory 的了。。
abstract class AbstractFactoryClass {
  void test();
  factory AbstractFactoryClass(){
    // 即使这里写了构造方法，直接报错，因为给它 factory 以后也只是看起来能被实例化而已
    // return AbstractFactoryClass._internal();
  }


  AbstractFactoryClass._internal();

  void log(){
    print("this is abstract class");
  }
}

// 单例
class SingleClass {

  factory SingleClass() {
    return _getInstance();
  }

  static SingleClass _instance;

  SingleClass._new(){

  }

  static SingleClass _getInstance(){
    if(_instance == null){
      _instance = new SingleClass._new();
    }
    return _instance;
  }

}

/**
 * factory 用来替代默认的构造函数，
 * 它使用起来和默认构造函数没有区别，
 * 但是在函数内部和构造函数是有区别的
 * - 它有返回值
 * - 内部不能使用 this 关键字 （猜测可能是因为它并不属于这个对象的原因，或者因为它其实不知道自己属于那个对象？）
 */
class Logger {
  final String name;
  bool isDebug = true;

  static final Map<String, Logger> _cache = <String, Logger>{};


  factory Logger(String name){
      if(_cache.containsKey(name)){
        return _cache[name];
      } else {
        final logger = Logger._internal(name);
        _cache[name] = logger;
        return logger;
      }
  }

  void log(String msg){
    if(isDebug) {
      print(msg);
    }
  }

  Logger._internal(this.name);
}


/**
 * 常量类
 */
class TestCosnt {

  final String data;

  final String name;
  final int age;

  /**
   * 当使用 cosnt 标记一个构造函数是，它类似于java的单例
   * 而且这个时候这个类中的变量都应该是 fianl 的
   */
  const TestCosnt(this.data,{
    this.name = "laowang",
    this.age = 10
  });
}



class InitializerTest {
  num x;
  num y;
  num sum;

  //  跟写到构造函数{} 中没有区别呀

  InitializerTest(x,y)
      :x = x,
      y = y,
      sum = x + y{
        print("in consturctor");
        printMe();
      }
  // 两者没区别
  // InitializerTest(x, y) : 
  //   assert(x != 0)
  //   {
  //     this.x = x;
  //     this.y = y;
  //     this.sum = x + y;
  //   }

  // 重定向构造函数
  InitializerTest.newInstance(x) : this(x,10);

  printMe(){
    print("x::$x  y::$y  sum::$sum");
  }

}


class Person{
  String firstName;

  Person(this.firstName);

   Person.fromJson(Map data) {
    print('in Person');
  }

}

class Employee extends Person {
  Employee(String name):super(name);
  // 如果父类有一个默认的构造函数，则不需要调用super
  // 或者父类有一个 非空构造函数 的时候 也是需要调用 super 的
  // 否则无法初始化父类
  Employee.fromJson(Map data):super.fromJson(data)  {
    print('in Employee');
  }

  // 否则假设父类没有构造函数则需要这样
    Employee.fromJson2(Map data):super.fromJson(data)  {
    print('in Employee');
  }
}




class Test{
  String name;
  num age;
  // 默认有一个无参构造函数
}

class Test2{
  String name;
  num age;

  Test2(String name, num age){
    this.name = name;
    this.age = age;
  }

}

class Test3{
  String name;
  num age;

  Test3(this.name, this.age);

  Test3.origin(){
    name = "maintel";
    age = 10;
  }

  Test3.newInstance(String name,int age){
    this.name = name;
    this.age = age;
  }
  
}