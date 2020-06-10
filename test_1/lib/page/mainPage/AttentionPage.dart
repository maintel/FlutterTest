import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/**
 * 关注页面
 */
class AttentionPage extends StatefulWidget {
  @override
  _AttentionPageState createState() => _AttentionPageState();
}

class _AttentionPageState extends State<AttentionPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              _getAttenTion()
              ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                _getAttenTion()
              ),
            ),
            ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,  // 每一行的宽度 不能超过屏幕的最大宽度
              mainAxisSpacing: 10,   // 平行于主坐标轴的间距， 竖直情况下就是 每行之间的距离 默认为0
              crossAxisSpacing: 20, // 垂直于主坐标轴的间距 竖直情况下就是 列间距  默认为0
              childAspectRatio: 2 //  垂直和平行坐标轴的宽高比。默认为1 比如竖直排列的话，设置为2就是宽 ： 高 2：1
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index){
                return Text("data");
              },
              childCount:10
            )
          )
        ],
    );
  }

  List<Text> _getAttenTion() {
    List<Text> list = List();
    for(var i = 0;i < 10;i++){
        list.add(Text("i::$i"));
    }
    return list;
  }
}