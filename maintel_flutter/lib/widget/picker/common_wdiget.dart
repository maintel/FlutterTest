import 'package:flutter/material.dart';

class WrapLayout extends SingleChildLayoutDelegate {
  WrapLayout({
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
  bool shouldRelayout(WrapLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

/// 通用的 title
class PickerTitleWidget extends StatelessWidget {
  final GestureTapCallback onCancel;
  final GestureTapCallback onComplete;
  final String negativeText;
  final Color negativeTextColor;
  final String positiveText;
  final Color positiveTextColor;

  PickerTitleWidget(
    this.onCancel,
    this.onComplete,
    this.negativeText,
    this.negativeTextColor,
    this.positiveText,
    this.positiveTextColor,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: onCancel,
          child: Padding(
            padding: EdgeInsets.all(2),
            child: Text(
              negativeText,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: negativeTextColor,
                  decoration: TextDecoration.none),
            ),
          ),
        ),
        Expanded(
          child: Container(),
          flex: 1,
        ),
        GestureDetector(
          onTap: onComplete,
          child: Padding(
            padding: EdgeInsets.all(2),
            child: Text(
              positiveText,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: positiveTextColor,
                  decoration: TextDecoration.none),
            ),
          ),
        )
      ],
    );
  }
}
