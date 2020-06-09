import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maintel_flutter/FirstPage.dart';
import 'package:maintel_flutter/getNativeData.dart';
import 'package:provider/provider.dart';
import 'package:flutter_boost/flutter_boost.dart';

// void main(){
//   //这一步确保创建 MethodChannel 之前设置好 flutter 绑定
//   WidgetsFlutterBinding.ensureInitialized();

//   final model = CounterModel();
//   runApp(
//     ChangeNotifierProvider.value(
//       value: model,
//       child: MyApp(),
//     )
//   );
// }

Widget _widgetForRoute(String route) {
  print("_widgetForRoute${route}");
  switch (route) {
    case "test":
      {
        print("_widgetForRoute");
        return Center(
            child: Text(
          "请设置好 route22222",
          textDirection: TextDirection.ltr,
        ));
      }
    default:
      {
        return FirstPage();
      }
  }
}

void main() => runApp(FirstPage());
// void main() => runApp(MyApp());

class CounterModel extends ChangeNotifier {
  final _channel = MethodChannel("maintel.flutter.test/counterTest");

  int _count = 0;

  int get count => _count;

  CounterModel() {
    _channel.setMethodCallHandler(_handleMessage);
    _channel.invokeMethod("requestCounter");
  }

  void increment() {
    _channel.invokeMethod("incrementCounter");
  }

  Future<dynamic> _handleMessage(MethodCall call) async {
    if (call.method == "reportCounter") {
      _count = call.arguments as int;
      notifyListeners();
    }
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        "/": (context) => MyHomePage(
              title: "Flutter Demo Home Page",
            ),
        "/test": (context) => Center(
              child: Text(
                "test test",
                textDirection: TextDirection.ltr,
              ),
            )
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  String _version = "0.0.1";

  void _setVersion(String version) {
    setState(() {
      _version = version;
    });
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Consumer<CounterModel>(builder: (context, model, child) {
              return Text("${model.count}",
                  style: Theme.of(context).textTheme.display1);
            }),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            Consumer<CounterModel>(
              builder: (context, model, child) {
                return RaisedButton(
                  onPressed: () => model.increment(),
                  child: Text('Tap me!'),
                );
              },
            ),
            Text("当前版本号为：$_version"),
            RaisedButton(
              onPressed: () => {
                NativeData.getVersion().then((version) {
                  _setVersion(version);
                })
              },
              child: Text("点击我，获取版本号"),
            ),
          ],
        ),
      ),
      floatingActionButton:
          Consumer<CounterModel>(builder: (context, model, child) {
        return FloatingActionButton(
            onPressed: () => model.increment(),
            tooltip: 'Increment',
            child: Icon(Icons.add));
      }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//使用 flutterboost
// void main() => runApp(MyApp());

// void main() => runApp(MyFlutterBoostApp());

class MyFlutterBoostApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    print("createStatecreateStatecreateState");

    // TODO: implement createState
    return _MyFlutterBoostAppState();
  }
}

class _MyFlutterBoostAppState extends State<MyFlutterBoostApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("dadadadad");
    FlutterBoost.singleton.registerPageBuilders(<String, PageBuilder>{
      "first": (pageName, params, _) =>
          MyHomePage(title: "Flutter Demo Home Page"),
      "second": (pageName, params, _) =>
          MyHomePage(title: "Flutter Demo Home Page2222"),
      'flutterPage': (pageName, params, _) {
        print('flutterPage params:$params');

        return FirstPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("buildbuildbuild");
    return MaterialApp(
      builder: FlutterBoost.init(postPush: _onRoutePushed),
      home: Center(
          child: Text(
        "flutter boost test",
        textDirection: TextDirection.ltr,
      )),
    );
  }

  void _onRoutePushed(String url, String uniqueId, Map<dynamic, dynamic> params,
      Route<dynamic> route, Future<dynamic> result) {}
}
