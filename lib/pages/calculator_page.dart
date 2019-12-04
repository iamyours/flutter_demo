import 'package:flutter/material.dart';
import '../widget/calculator_item.dart';
import '../utils/image_helper.dart';
import '../utils/calculator.dart';
import '../utils/widget_util.dart';


class CalculatorPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CalculatorPageState();
  }
}

class _CalculatorPageState extends State<CalculatorPage> with TickerProviderStateMixin {
  String text1 = "";
  String text2 = "";

  AnimationController controller;
  Animation<double> animation;
  double top1 = 100;
  double top2 = 150;
  double font1 = 35;
  double font2 = 20;
  bool hideFont2 = false;
  static Calculator calculator = Calculator();
  double fontLevel1, fontLevel2;
  double currentFontLevel;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    CurvedAnimation easy = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = Tween(begin: 0.0, end: 1.0).animate(easy)
      ..addListener(() {
        double v = animation.value * 50;
        double level = text2.length > 15 ? fontLevel2 : fontLevel1;
        double f = animation.value * (level - fontLevel2);
        top1 = 100 - v;
        top2 = 150 - v;
        font2 = fontLevel2 + f;
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          top1 = 100;
          top2 = 150;
          hideFont2 = true;
          text1 = text2;
          calculator.reset(text2);
          text2 = "";
          setState(() {});
          controller.reset();
        } else if (status == AnimationStatus.forward) {
          setState(() {
            hideFont2 = false;
          });
        }
      });
  }

  double getLevel() {
    return currentFontLevel;
  }

  void addText(text) {
    calculator.addText(text);
    var value = calculator.calculate();
    setState(() {
      text1 = calculator.expressionText();
      text2 = value;
      hideFont2 = false;
      currentFontLevel = text1.length > 15 ? fontLevel2 : fontLevel1;
      font1 = currentFontLevel;
    });
  }

  void calculateAndUpdate() {
    if (text2.isEmpty) return;
    controller.forward();
  }

  Widget buildNumberItem(String text) {
    return CalculatorItem(
      activeColor: Color(0xffD3D3D3),
      color: Color(0xFF1D3247),
      onTap: () => addText(text),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: WidgetUtil.getFontSize(34), color: Colors.white, fontFamily: "din_medium"),
        ),
      ),
    );
  }

  Widget buildOperateItem(String icon, String text) {
    return CalculatorItem(
      activeColor: Color(0xff58B0EF),
      color: Color(0xFF255585),
      onTap: () => addText(text),
      child: Center(
        child: ImageHelper.icon(icon, width: WidgetUtil.getWidth(16)),
      ),
    );
  }

  Widget buildDelItem() {
    return CalculatorItem(
      color: Color(0xff4A6584),
      activeColor: Color(0xff58B0EF),
      onTap: () => addText("<"),
      child: Center(
        child: ImageHelper.icon("ic_delete", width: WidgetUtil.getWidth(21)),
      ),
    );
  }

  Widget buildClearItem() {
    return CalculatorItem(
      onTap: () => addText("C"),
      color: Color(0xff4A6584),
      activeColor: Color(0xff58B0EF),
      child: Center(
        child: Text(
          "C",
          style: TextStyle(color: Colors.white, fontSize: WidgetUtil.getFontSize(28)),
        ),
      ),
    );
  }

  Widget buildEqualItem() {
    return CalculatorItem(
      onTap: calculateAndUpdate,
      width: WidgetUtil.getWidth(120) + 16,
      activeColor: Color(0xff58B0EF),
      color: Color(0xFF255585),
      child: Center(child: ImageHelper.icon("ic_equal", width: 16)),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetUtil.init(context);
    fontLevel1 = WidgetUtil.getFontSize(38);
    fontLevel2 = WidgetUtil.getFontSize(28);
    currentFontLevel = fontLevel1;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: top1,
            right: 5,
            child: Container(
                height: 50,
                child: Center(
                  child: Text(
                    text1,
                    style: TextStyle(fontSize: font1, color: const Color(0xff333333), fontFamily: "din_medium"),
                  ),
                )),
          ),
          Positioned(
              top: top2,
              right: 5,
              child: Offstage(
                offstage: hideFont2,
                child: Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        text2,
                        style: TextStyle(fontSize: font2, color: const Color(0xffCCCCCC), fontFamily: "din_medium"),
                      ),
                    )),
              )),
          Positioned(
            bottom: 0,
            left: 0.0,
            right: 0.0,
            child: Container(
              color: Color(0xFF1D3247),
              padding: EdgeInsets.only(bottom: WidgetUtil.getWidth(20)),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      buildNumberItem("7"),
                      buildNumberItem("8"),
                      buildNumberItem("9"),
                      buildClearItem(),
                      buildDelItem(),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildNumberItem("4"),
                      buildNumberItem("5"),
                      buildNumberItem("6"),
                      buildOperateItem("ic_opt_add", "+"),
                      buildOperateItem("ic_opt_sub", "-")
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildNumberItem("1"),
                      buildNumberItem("2"),
                      buildNumberItem("3"),
                      buildOperateItem("ic_opt_mul", "×"),
                      buildOperateItem("ic_opt_div", "÷")
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildNumberItem("00"),
                      buildNumberItem("0"),
                      buildNumberItem("."),
                      buildEqualItem()
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
