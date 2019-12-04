import 'package:flutter/material.dart';
import '../utils/widget_util.dart';

class CalculatorItem extends StatefulWidget {
  final Color activeColor;
  final Color color;
  final Widget child;
  final GestureTapCallback onTap;
  final double width;

  const CalculatorItem({Key key, this.activeColor, this.color, this.child, this.onTap, this.width}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CalculatorItemState(activeColor, color, child, onTap, width);
  }
}

class _CalculatorItemState extends State<CalculatorItem> {
  bool active = false;
  final Color activeColor;
  final Color color;
  final Widget child;
  final GestureTapCallback onTap;
  final double width;

  _CalculatorItemState(this.activeColor, this.color, this.child, this.onTap, this.width);

  void _active(bool flag) {
    setState(() {
      active = flag;
    });
  }

  @override
  Widget build(BuildContext context) {
    double dp8 = WidgetUtil.getWidth(8);
    double dp24 = WidgetUtil.getWidth(24);
    double dp60 = WidgetUtil.getWidth(58);
    return GestureDetector(
        onTapDown: (arg) => _active(true),
        onTapUp: (arg) => _active(false),
        onTapCancel: () => _active(false),
        onTap: onTap,
        child: Container(
            margin: EdgeInsets.fromLTRB(dp8, dp24, dp8, 0),
            width: width ?? dp60,
            height: dp60,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(dp60 / 2), color: active ? activeColor : color),
            child: child));
  }
}
