import 'package:flutter/material.dart';

class CursorView extends StatefulWidget {
  final double height;

  const CursorView({Key key, this.height}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CursorViewState(height);
  }
}

class _CursorViewState extends State<CursorView> with SingleTickerProviderStateMixin {
  final double height;

  _CursorViewState(this.height);

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: Container(
        margin: EdgeInsets.only(right: 16,left: 2),
        width: 1.5,
        height: height,
        color: Colors.blue[400],
      ),
    );
  }
}
