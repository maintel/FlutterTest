import 'package:flutter/material.dart';
import 'package:maintel_flutter/widget/picker/list_picker/list_picker_wheel.dart';
import 'package:maintel_flutter/widget/picker/list_picker/list_result.dart';

import '../popu_route.dart';

const Color _defaultPostiveTextColor = Color(0xffFF7459);
const Color _defaultNegativeTextColor = Color(0xff9C9C9C);
const Color _defaultBgTextColor = Color(0xffffffff);

/// 列表选择器
/// [T] 类型 如果不是 string ，一定要重写 toString 方法
class ListPicker<T> extends StatefulWidget {
  final List<T> contentList;
  final Color backgroundColor;
  final Color positiveTextColor;
  final Color negativeTextColor;
  final String positiveText;
  final String negativeText;
  final double height;
  final String leftText;
  final String rightText;

  ListPicker(this.contentList,
      {this.positiveText = "完成",
      this.negativeText = "取消",
      this.height = 300,
      this.leftText,
      this.rightText,
      this.backgroundColor = _defaultBgTextColor,
      this.positiveTextColor = _defaultPostiveTextColor,
      this.negativeTextColor = _defaultNegativeTextColor});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListPickerWidget();
  }
}

class _ListPickerWidget extends State<ListPicker> {
  int _currentSelectItem = 0;

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
                  height: widget.height,
                  color: widget.backgroundColor,
                  child: Column(
                    children: <Widget>[
                      _getTitleWidget(),
                      Container(
                        margin: EdgeInsets.only(top: 14, bottom: 16.5),
                        height: 1,
                        color: Color(0xffEEEEEE),
                      ),
                      Expanded(
                        child: _getWheelWidget(),
                        flex: 1,
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
          onTap: () {
            Navigator.pop(context, PickerResult(-1, null));
          },
          child: Padding(
            padding: EdgeInsets.all(2),
            child: Text(
              widget.negativeText,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: widget.negativeTextColor,
                  decoration: TextDecoration.none),
            ),
          ),
        ),
        Expanded(
          child: Container(),
          flex: 1,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(
                context,
                PickerResult(_currentSelectItem,
                    widget.contentList[_currentSelectItem]));
          },
          child: Padding(
            padding: EdgeInsets.all(2),
            child: Text(
              widget.positiveText,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: widget.positiveTextColor,
                  decoration: TextDecoration.none),
            ),
          ),
        )
      ],
    );
  }

  /// 内容列表
  Widget _getWheelWidget() {
    return Container(
      decoration: BoxDecoration(),
      child: MyCupertinoPicker(
        children: _getWheelItemWidget(),
        onSelectedItemChanged: (item) {
          print(item);
          _currentSelectItem = item;
        },
        leftDecorationWidget: _leftTextWidget(),
        rightDecorationWidget: _rightTextWidget(),
      ),
    );
  }

  List<Widget> _getWheelItemWidget() {
    var list = List<Widget>();
    for (var item in widget.contentList) {
      list.add(Align(
        alignment: Alignment.center,
        child: Text(item.toString(), style: TextStyle(fontSize: 20)),
      ));
    }
    return list;
  }

  Widget _leftTextWidget() {
    if (widget.leftText != null) {
      return Align(
        child: Text(
          widget.leftText,
          style: TextStyle(fontSize: 20),
        ),
        alignment: Alignment.centerLeft,
      );
    } else {
      return Text("");
    }
  }

  Widget _rightTextWidget() {
    if (widget.rightText != null) {
      return Align(
        child: Text(widget.rightText, style: TextStyle(fontSize: 20)),
        alignment: Alignment.centerRight,
      );
    } else {
      return Text("");
    }
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
