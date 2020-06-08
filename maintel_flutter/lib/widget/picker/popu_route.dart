import 'package:flutter/material.dart';

/// 从底部弹出 popuwindow 切换动画
/// @author jieyu.chen
/// @date 2020年6月8日
class CommonButtonPopuRoute<T> extends PopupRoute<T> {

  Widget child;


  CommonButtonPopuRoute({this.child});

  /// 透明度
  @override
  Color get barrierColor => Color.fromRGBO(0, 0, 0, 0.5);

  @override
  // TODO: implement barrierDismissible
  bool get barrierDismissible => false;

  @override
  // TODO: implement barrierLabel
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    // TODO: implement buildPage
    Widget bottomSheet = new MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: InheritRouteWidget(router: this, child: child));
    // if (theme != null) {
    //   bottomSheet = new Theme(data: theme, child: bottomSheet);
    // }
    return bottomSheet;
  }

  @override
  AnimationController createAnimationController() {
    // TODO: implement createAnimationController
    return BottomSheet.createAnimationController(navigator.overlay);
  }

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => Duration(milliseconds: 2000);

}


class InheritRouteWidget extends InheritedWidget {
  final CommonButtonPopuRoute router;

  InheritRouteWidget({Key key, @required this.router, Widget child})
      : super(key: key, child: child);

  static InheritRouteWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(InheritRouteWidget);
  }

  @override
  bool updateShouldNotify(InheritRouteWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return oldWidget.router != router;
  }
}