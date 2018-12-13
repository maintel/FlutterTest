

  const test = [];
  var test2 = SwitchCase();
  var test3 = SwitchCase();

main(List<String> args) {
  
  //  因为是闭包，以及完全的面向对象特性，所以有这样的神奇写法
  var callbacks = [];
  for (var i = 0; i < 2; i++) {
    callbacks.add(() => print(i));
  }
  callbacks.forEach((c) => c());



  var testList = [test,test2,test3];

  testList.forEach((item){
    switch(item){
      case test:
        print(1);
        break;
      // case "true": // 僵硬 不能这样用
      //   break;
    }
  });

}


class SwitchCase{

}