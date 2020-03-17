import 'package:flutter/material.dart';

class CanvasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          size: Size(300, 300),
          painter: _CanvasPainter(),
        ),
      ),
    );
  }
}

class _CanvasPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var w = 200.0;
    var h = 200.0;
    var r = 15.0;
    var w2 = w / 2;
    var gapW = 36.0;
    var gapW2 = gapW / 2;
    var gapH = 15.0;
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke //填充
      ..strokeWidth = 2.0
      ..color = Colors.red; //背景为纸黄色
    var path = Path()
          ..moveTo(0, 0)
//          ..lineTo(w - r, 0)
//          ..quadraticBezierTo(w, 0, w, r)
//          ..lineTo(w, h - r)
//          ..quadraticBezierTo(w, h, w - r, h)
//          ..lineTo(w2 + gapW2, h)
//          ..quadraticBezierTo(w2 + gapW2 - 10, h, w2, h + gapH)
//          ..quadraticBezierTo(w2, h + gapH, w2 - gapW2+10, h)



    ..quadraticBezierTo(10, 0, 20, 10)
    ..quadraticBezierTo(20, 10, 20, 30)
//      ..close();
        ;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
