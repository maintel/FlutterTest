main(List<String> args) {
  var map = {1:"test","aa":String};
  map["booleanKey"] = true;
  map.forEach((key,value){
    print("key::$key   value:$value");
  });
}

var test = "tet";

bool isString(Object obj){
  return obj is String;
}

isString2(Object obj){
  return obj is String;
}

isString3(Object obj) => obj is String;