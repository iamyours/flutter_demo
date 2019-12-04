import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetUtil {
  static void init(BuildContext context){
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);
  }

  static double getWidth(double value){
    return ScreenUtil.getInstance().setWidth(value);
  }

  static double getFontSize(double value){
    return ScreenUtil.getInstance().setWidth(value);
  }


  static Widget titleText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 21, color: Color(0xff333333), fontWeight: FontWeight.bold),
    );
  }

  static void showLoading(BuildContext context){
    showDialog(
        context: context,
        builder: (context) {
          return UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: SizedBox(
              width: 165,
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularProgressIndicator(
                      strokeWidth: 1.8,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static double getTextWidth(String text, double fontSize) {
    var constraints = BoxConstraints(maxWidth: double.infinity, minWidth: 0.0, minHeight: 0.0);
    var render = RenderParagraph(TextSpan(text: text, style: TextStyle(fontSize: fontSize)),
        textDirection: TextDirection.ltr, maxLines: 1);
    render.layout(constraints);
    double textLen = render.getMinIntrinsicWidth(fontSize).ceilToDouble();
    return textLen;
  }
}
