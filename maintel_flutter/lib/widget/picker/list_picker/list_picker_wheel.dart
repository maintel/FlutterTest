// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Color of the 'magnifier' lens border.
const Color _kHighlighterBgColor = Color(0xFFF6F6F6);
const Color _kDefaultBackground = Color(0xffffffff);
// Eyeballed values comparing with a native picker to produce the right
// curvatures and densities.
const double _kDefaultDiameterRatio = 2.5;
const double _kDefaultPerspective = 0.003;
const double _kSqueeze = 0.9;

/// Opacity fraction value that hides the wheel above and below the 'magnifier'
/// lens with the same color as the background.
const double _kForegroundScreenOpacityFraction = 0.7;

/// ios 风格列表选择器
class MyCupertinoPicker extends StatefulWidget {
  /// Creates a picker from a concrete list of children.
  ///
  /// The [diameterRatio] and [itemExtent] arguments must not be null. The
  /// [itemExtent] must be greater than zero.
  ///
  /// The [backgroundColor] defaults to light gray. It can be set to null to
  /// disable the background painting entirely; this is mildly more efficient
  /// than using [Colors.transparent]. Also, if it has transparency, no gradient
  /// effect will be rendered.
  ///
  /// The [scrollController] argument can be used to specify a custom
  /// [FixedExtentScrollController] for programmatically reading or changing
  /// the current picker index or for selecting an initial index value.
  ///
  /// The [looping] argument decides whether the child list loops and can be
  /// scrolled infinitely.  If set to true, scrolling past the end of the list
  /// will loop the list back to the beginning.  If set to false, the list will
  /// stop scrolling when you reach the end or the beginning.
  MyCupertinoPicker({
    Key key,
    this.diameterRatio = _kDefaultDiameterRatio,
    this.backgroundColor = _kDefaultBackground,
    this.hightLighterBgColor = _kHighlighterBgColor,
    this.offAxisFraction = 0.0,
    this.useMagnifier = false,
    this.magnification = 1.2,
    this.scrollController,
    this.squeeze = _kSqueeze,
    this.itemExtent = 30,
    this.rightDecorationWidget,
    this.leftDecorationWidget,
    @required this.onSelectedItemChanged,
    @required List<Widget> children,
    bool looping = false,
  })  : assert(children != null),
        assert(diameterRatio != null),
        assert(diameterRatio > 0.0,
            RenderListWheelViewport.diameterRatioZeroMessage),
        assert(magnification > 0),
        assert(itemExtent != null),
        assert(itemExtent > 0),
        assert(squeeze != null),
        assert(squeeze > 0),
        childDelegate = looping
            ? ListWheelChildLoopingListDelegate(children: children)
            : ListWheelChildListDelegate(children: children),
        super(key: key);

  /// Creates a picker from an [IndexedWidgetBuilder] callback where the builder
  /// is dynamically invoked during layout.
  ///
  /// A child is lazily created when it starts becoming visible in the viewport.
  /// All of the children provided by the builder are cached and reused, so
  /// normally the builder is only called once for each index (except when
  /// rebuilding - the cache is cleared).
  ///
  /// The [itemBuilder] argument must not be null. The [childCount] argument
  /// reflects the number of children that will be provided by the [itemBuilder].
  /// {@macro flutter.widgets.wheelList.childCount}
  ///
  /// The [itemExtent] argument must be non-null and positive.
  ///
  /// The [backgroundColor] defaults to light gray. It can be set to null to
  /// disable the background painting entirely; this is mildly more efficient
  /// than using [Colors.transparent].
  MyCupertinoPicker.builder({
    Key key,
    this.diameterRatio = _kDefaultDiameterRatio,
    this.backgroundColor = _kDefaultBackground,
    this.hightLighterBgColor = _kHighlighterBgColor,
    this.offAxisFraction = 0.0,
    this.useMagnifier = false,
    this.magnification = 1.2,
    this.scrollController,
    this.squeeze = _kSqueeze,
    this.itemExtent = 30,
    this.rightDecorationWidget,
    this.leftDecorationWidget,
    @required this.onSelectedItemChanged,
    @required IndexedWidgetBuilder itemBuilder,
    int childCount,
  })  : assert(itemBuilder != null),
        assert(diameterRatio != null),
        assert(diameterRatio > 0.0,
            RenderListWheelViewport.diameterRatioZeroMessage),
        assert(magnification > 0),
        assert(itemExtent != null),
        assert(itemExtent > 0),
        assert(squeeze != null),
        assert(squeeze > 0),
        childDelegate = ListWheelChildBuilderDelegate(
            builder: itemBuilder, childCount: childCount),
        super(key: key);

  /// Relative ratio between this picker's height and the simulated cylinder's diameter.
  ///
  /// Smaller values creates more pronounced curvatures in the scrollable wheel.
  ///
  /// For more details, see [ListWheelScrollView.diameterRatio].
  ///
  /// Must not be null and defaults to `1.1` to visually mimic iOS.
  /// 高度和模拟圆柱体直径之间的比率，越小滚动起来时圆柱体越明显 默认是2.5
  final double diameterRatio;

  /// Background color behind the children.
  ///
  /// Defaults to a gray color in the iOS color palette.
  ///
  /// This can be set to null to disable the background painting entirely; this
  /// is mildly more efficient than using [Colors.transparent].
  ///
  /// Any alpha value less 255 (fully opaque) will cause the removal of the
  /// wheel list edge fade gradient from rendering of the widget.
  final Color backgroundColor;

  final Color hightLighterBgColor;

  /// {@macro flutter.rendering.wheelList.offAxisFraction}
  /// X坐标轴方向的弯曲程度，越大弯曲的越厉害
  final double offAxisFraction;

  /// {@macro flutter.rendering.wheelList.useMagnifier}
  ///  是否启用放大镜，默认为不启用
  final bool useMagnifier;

  /// 选中条目的方法倍率，默认为1.2
  final double magnification;

  /// A [FixedExtentScrollController] to read and control the current item, and
  /// to set the initial item.
  ///
  /// If null, an implicit one will be created internally.
  final FixedExtentScrollController scrollController;

  /// item 的高度 默认为30
  final double itemExtent;

  /// 条目之间的间隔，默认为0.9 越小间隔越大
  final double squeeze;

  /// An option callback when the currently centered item changes.
  ///
  /// Value changes when the item closest to the center changes.
  ///
  /// This can be called during scrolls and during ballistic flings. To get the
  /// value only when the scrolling settles, use a [NotificationListener],
  /// listen for [ScrollEndNotification] and read its [FixedExtentMetrics].
  final ValueChanged<int> onSelectedItemChanged;

  /// A delegate that lazily instantiates children.
  final ListWheelChildDelegate childDelegate;

  ///右侧附加 Widget
  final Widget rightDecorationWidget;

  /// 左侧附加 Widget
  final Widget leftDecorationWidget;

  @override
  State<StatefulWidget> createState() => _CupertinoPickerState();
}

class _CupertinoPickerState extends State<MyCupertinoPicker> {
  int _lastHapticIndex;
  FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.scrollController == null) {
      _controller = FixedExtentScrollController();
    }
  }

  @override
  void didUpdateWidget(MyCupertinoPicker oldWidget) {
    if (widget.scrollController != null && oldWidget.scrollController == null) {
      _controller = null;
    } else if (widget.scrollController == null &&
        oldWidget.scrollController != null) {
      assert(_controller == null);
      _controller = FixedExtentScrollController();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _handleSelectedItemChanged(int index) {
    // Only the haptic engine hardware on iOS devices would produce the
    // intended effects.
    bool hasSuitableHapticHardware;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        hasSuitableHapticHardware = true;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        hasSuitableHapticHardware = false;
        break;
    }
    assert(hasSuitableHapticHardware != null);
    if (hasSuitableHapticHardware && index != _lastHapticIndex) {
      _lastHapticIndex = index;
      HapticFeedback.selectionClick();
    }

    if (widget.onSelectedItemChanged != null) {
      widget.onSelectedItemChanged(index);
    }
  }

  /// Makes the fade to [CupertinoPicker.backgroundColor] edge gradients.
  Widget _buildGradientScreen() {

    if (widget.backgroundColor != null && widget.backgroundColor.alpha < 255)
      return Container();

    final Color widgetBackgroundColor =
        widget.backgroundColor ?? const Color(0xFFFFFFFF);
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                widgetBackgroundColor,
                widgetBackgroundColor.withAlpha(0xF2),
                widgetBackgroundColor.withAlpha(0xDD),
                widgetBackgroundColor.withAlpha(0),
                widgetBackgroundColor.withAlpha(0),
                widgetBackgroundColor.withAlpha(0xDD),
                widgetBackgroundColor.withAlpha(0xF2),
                widgetBackgroundColor,
              ],
              stops: const <double>[
                0.0,
                0.05,
                0.09,
                0.22,
                0.78,
                0.91,
                0.95,
                1.0,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }

  /// 选中地方高亮
  /// 使用了一个遮罩，让未选中的部分叠加显示成灰色，选中部分显示出原来的颜色
  Widget _buildMagnifierScreen() {
    final Color foreground = widget.backgroundColor?.withAlpha(
        (widget.backgroundColor.alpha * _kForegroundScreenOpacityFraction)
            .toInt());

    return IgnorePointer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: foreground,
            ),
          ),
          Container(
            decoration: BoxDecoration(),
            constraints: BoxConstraints.expand(
              height: widget.itemExtent * widget.magnification,
            ),
          ),
          Expanded(
            child: Container(
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }

  /// 选中部分的颜色，
  Widget _buildUnderMagnifierScreen() {
    return Column(
      children: <Widget>[
        Expanded(child: Container()),
        Container(
          // color:  Colors.red,
          decoration: BoxDecoration(
              color: widget.hightLighterBgColor,
              borderRadius: BorderRadius.all(Radius.circular(100))),
          constraints: BoxConstraints.expand(
            height: widget.itemExtent * widget.magnification,
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }

  /// 添加背景
  Widget _addBackgroundToChild(Widget child) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
      ),
      child: child,
    );
  }

  /// 1.绘制选中区域
  /// 2.绘制滚动列表
  /// 3.绘制未选中区域蒙版
  /// 4.绘制边缘区域渐隐
  /// 5.添加背景
  @override
  Widget build(BuildContext context) {
    Widget result = DefaultTextStyle(
      style: CupertinoTheme.of(context).textTheme.pickerTextStyle,
      child: Stack(
        children: <Widget>[
          _buildUnderMagnifierScreen(),
          Positioned.fill(
            child: _CupertinoPickerSemantics(
              scrollController: widget.scrollController ?? _controller,
              child: ListWheelScrollView.useDelegate(
                controller: widget.scrollController ?? _controller,
                physics: const FixedExtentScrollPhysics(),
                diameterRatio: widget.diameterRatio,
                perspective: _kDefaultPerspective,
                offAxisFraction: widget.offAxisFraction,
                useMagnifier: widget.useMagnifier,
                magnification: widget.magnification,
                itemExtent: widget.itemExtent,
                squeeze: widget.squeeze,
                onSelectedItemChanged: _handleSelectedItemChanged,
                childDelegate: widget.childDelegate,
              ),
            ),
          ),
          _buildMagnifierScreen(),
          _buildGradientScreen(),
          widget.rightDecorationWidget ?? Text(""),
          widget.leftDecorationWidget ?? Text(""),
        ],
      ),
    );
    result = _addBackgroundToChild(result);
    return result;
  }
}

// Turns the scroll semantics of the ListView into a single adjustable semantics
// node. This is done by removing all of the child semantics of the scroll
// wheel and using the scroll indexes to look up the current, previous, and
// next semantic label. This label is then turned into the value of a new
// adjustable semantic node, with adjustment callbacks wired to move the
// scroll controller.
class _CupertinoPickerSemantics extends SingleChildRenderObjectWidget {
  const _CupertinoPickerSemantics({
    Key key,
    Widget child,
    @required this.scrollController,
  }) : super(key: key, child: child);

  final FixedExtentScrollController scrollController;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderCupertinoPickerSemantics(
          scrollController, Directionality.of(context));

  @override
  void updateRenderObject(BuildContext context,
      covariant _RenderCupertinoPickerSemantics renderObject) {
    renderObject
      ..textDirection = Directionality.of(context)
      ..controller = scrollController;
  }
}

class _RenderCupertinoPickerSemantics extends RenderProxyBox {
  _RenderCupertinoPickerSemantics(
      FixedExtentScrollController controller, this._textDirection) {
    this.controller = controller;
  }

  FixedExtentScrollController get controller => _controller;
  FixedExtentScrollController _controller;
  set controller(FixedExtentScrollController value) {
    if (value == _controller) return;
    if (_controller != null)
      _controller.removeListener(_handleScrollUpdate);
    else
      _currentIndex = value.initialItem ?? 0;
    value.addListener(_handleScrollUpdate);
    _controller = value;
  }

  TextDirection get textDirection => _textDirection;
  TextDirection _textDirection;
  set textDirection(TextDirection value) {
    if (textDirection == value) return;
    _textDirection = value;
    markNeedsSemanticsUpdate();
  }

  int _currentIndex = 0;

  void _handleIncrease() {
    controller.jumpToItem(_currentIndex + 1);
  }

  void _handleDecrease() {
    if (_currentIndex == 0) return;
    controller.jumpToItem(_currentIndex - 1);
  }

  void _handleScrollUpdate() {
    if (controller.selectedItem == _currentIndex) return;
    _currentIndex = controller.selectedItem;
    markNeedsSemanticsUpdate();
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config.isSemanticBoundary = true;
    config.textDirection = textDirection;
  }

  @override
  void assembleSemanticsNode(SemanticsNode node, SemanticsConfiguration config,
      Iterable<SemanticsNode> children) {
    if (children.isEmpty)
      return super.assembleSemanticsNode(node, config, children);
    final SemanticsNode scrollable = children.first;
    final Map<int, SemanticsNode> indexedChildren = <int, SemanticsNode>{};
    scrollable.visitChildren((SemanticsNode child) {
      assert(child.indexInParent != null);
      indexedChildren[child.indexInParent] = child;
      return true;
    });
    if (indexedChildren[_currentIndex] == null) {
      return node.updateWith(config: config);
    }
    config.value = indexedChildren[_currentIndex].label;
    final SemanticsNode previousChild = indexedChildren[_currentIndex - 1];
    final SemanticsNode nextChild = indexedChildren[_currentIndex + 1];
    if (nextChild != null) {
      config.increasedValue = nextChild.label;
      config.onIncrease = _handleIncrease;
    }
    if (previousChild != null) {
      config.decreasedValue = previousChild.label;
      config.onDecrease = _handleDecrease;
    }
    node.updateWith(config: config);
  }
}
