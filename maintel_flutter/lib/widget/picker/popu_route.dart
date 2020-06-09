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

  /// 点击外部关闭
  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  ///
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
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

  /// 设置动画
  @override
  AnimationController createAnimationController() {
    return AnimationController(
        duration: transitionDuration,
        // debugLabel: 'BottomSheet',
        vsync: navigator.overlay);
  }

  /// 动画持续时间
  @override
  Duration get transitionDuration => Duration(milliseconds: 200);
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
