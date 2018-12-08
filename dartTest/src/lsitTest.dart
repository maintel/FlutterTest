main(List<String> args) {
  
  var testList = [1,2,3,"string"];
  testList.add(10);
  testList.add(11);
  testList.add(12);
  testList.add("13");
  testList.add(false);
  print(testList);

  var list = List();
  list.add(1);
  list.add(true);
  list.add("String");
  print(list);

  list.forEach(test);
  // 感觉这个没有 lamdba 表达式来的方便
  list.forEach((t){
    print(t);
  });
  list.forEach((t) => sort(4,5));

  print(sort(3,5));
}

test(Object t){
  print(t);
}

int sort(int a,int b) => a-b;