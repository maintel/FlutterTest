import 'package:flutter/material.dart';

import '../popu_route.dart';

class ListPicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListPickerWidget();
  }
}

class _ListPickerWidget extends State<ListPicker> {
  @override
  Widget build(BuildContext context) {
    final route = InheritRouteWidget.of(context).router;
    return AnimatedBuilder(
        animation: route.animation,
        builder: (BuildContext context, Widget child) {
          return CustomSingleChildLayout(
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                child: Container(
                  padding:
                      EdgeInsets.only(top: 16, left: 15, right: 15, bottom: 20),
                  height: 400,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      _getTitleWidget(),
                      Container(
                        margin: EdgeInsets.only(top: 14, bottom: 16.5),
                        height: 1,
                        color: Color(0xffEEEEEE),
                      ),
                      Column(
                        children: _getWheelWidget(),
                      )
                    ],
                  ),
                )),
            delegate: _WrapLayout(progress: route.animation.value, height: 400),
          );
        });
  }

  /// 绘制顶部 title
  Widget _getTitleWidget() {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () => {print("取消被点击")},
          child: Padding(
            padding: EdgeInsets.all(2),
            child: Text(
              "取消",
              style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 16,
                  color: Color(0xff9C9C9C),
                  decoration: TextDecoration.none),
            ),
          ),
        ),
        Expanded(
          child: Container(),
          flex: 1,
        ),
        GestureDetector(
          onTap: () => {"完成被点击"},
          child: Padding(
            padding: EdgeInsets.all(2),
            child: Text(
              "完成",
              style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 16,
                  color: Color(0xffFF7459),
                  decoration: TextDecoration.none),
            ),
          ),
        )
      ],
    );
  }

  /// 内容列表
  List<Widget> _getWheelWidget() {
    var list = {"aaa", "bbb", "ccc"};
    var listWidget = List<Widget>();

    for (var item in list) {
      listWidget.add(WheelItemWidget(item));
    }

    return listWidget;
  }
}

class _WrapLayout extends SingleChildLayoutDelegate {
  _WrapLayout({
    this.progress,
    this.height,
  });

  final double progress;
  final double height;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = height;

    return new BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double height = size.height - childSize.height * progress;
    return new Offset(0.0, height);
  }

  @override
  bool shouldRelayout(_WrapLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

class WheelItemWidget extends StatelessWidget {
  String _label;

  WheelItemWidget(this._label);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(_label);
  }
}
