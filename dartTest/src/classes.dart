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


class Person{
  String firstName;

  Person(this.firstName);

  Person.test(){

  }

}

class Employee extends Person {
  Employee(String name):super(name);
  // 如果父类有一个默认的构造函数，则不需要调用super
  // 或者父类有一个 非空构造函数 的时候 也是需要调用 super 的
  // 否则无法初始化父类
  Employee.fromJson(Map data):super.test()  {
    print('in Employee');
  }

  // 否则假设父类没有构造函数则需要这样
    Employee.fromJson2(Map data):super.test()  {
    print('in Employee');
  }
}