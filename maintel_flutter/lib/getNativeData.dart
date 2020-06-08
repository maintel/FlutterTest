
import 'package:flutter/services.dart';

class NativeData{
  static const MethodChannel _methodChannel = MethodChannel("com.maintel.fluttertest");

  static Future<String> getVersion() async {
    return await _methodChannel.invokeMethod("getVersion");
  }

}
