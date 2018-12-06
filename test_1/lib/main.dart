import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import './statClass.dart';

// 程序入口
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title:'Test 2',
      theme: ThemeData(
        primaryColor: Colors.grey
      ),
      home: RandomWords()
    );
  }
}

