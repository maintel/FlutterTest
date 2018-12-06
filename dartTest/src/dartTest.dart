main() {
  for (num i = 0; i < 5; i++) {
    printNumber(i);
  }

  var test = Test();
  test._sayBye();
}

printNumber(num aNumber){
  print("this num is ${aNumber + 10}");
}

_printString(String str){
  print(str);
}


class Test {
  sayHello(){
    print("hello word");
  }

  _sayBye(){
    print("bye bye");
  }
}