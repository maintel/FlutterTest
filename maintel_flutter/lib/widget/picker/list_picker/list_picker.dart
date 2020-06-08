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
            child: Container(
              height: 400,
              color: Colors.blueGrey[300],
              child: Text("data"),
            ),
            delegate: _WrapLayout(progress: route.animation.value, height: 400),
          );
        });
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
