import 'package:flutter/material.dart';
import '../utils/image_helper.dart';
import 'package:flutter/rendering.dart';

class SearchView extends StatefulWidget {
  final TextEditingController controller;
  final String hint;

  const SearchView({Key key, this.controller, this.hint}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchViewState(controller, hint);
  }
}

class _SearchViewState extends State<SearchView> with TickerProviderStateMixin {
  final String hint;
  final String cancelText = "取消";
  double _left = 0;
  double _right = 16;
  double maxLeft = 0;
  double _textLen;
  double _screenWidth;
  double _cancelWidth;
  FocusNode _focusNode = FocusNode();
  final TextEditingController _controller;

  _SearchViewState(this._controller, this.hint);

  static double getTextWidth(String text, double fontSize) {
    var constraints = BoxConstraints(maxWidth: double.infinity, minWidth: 0.0, minHeight: 0.0);
    var render = RenderParagraph(TextSpan(text: text, style: TextStyle(fontSize: fontSize)),
        textDirection: TextDirection.ltr, maxLines: 1);
    render.layout(constraints);
    double textLen = render.getMinIntrinsicWidth(fontSize).ceilToDouble();
    return textLen;
  }

  void _init() {
    _screenWidth = MediaQuery.of(context).size.width;
    _textLen = getTextWidth(hint, 13);
    _cancelWidth = getTextWidth(cancelText, 16) + 32;
    maxLeft = (_screenWidth - 32 - (_textLen + 12 + 4)) / 2;
    _left = maxLeft;
    setState(() {});
    animController = AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    CurvedAnimation curv = CurvedAnimation(parent: animController, curve: Curves.easeInOut);
    cancelController = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    CurvedAnimation curv2 = CurvedAnimation(parent: cancelController, curve: Curves.easeInExpo);

    cancelAnimation = Tween(begin: 16.0, end: _cancelWidth).animate(curv2)
      ..addListener(() {
        setState(() {
          _right = cancelAnimation.value;
        });
      });
    animation = Tween(begin: maxLeft, end: 0.0).animate(curv)
      ..addListener(() {
        setState(() {
          _left = animation.value;
        });
      });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        animController.forward();
        cancelController.forward();
      } else {
        animController.reverse();
        cancelController.reverse();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    animController.dispose();
    cancelController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _init();
  }

  AnimationController animController, cancelController;
  Animation<double> animation, cancelAnimation;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      color: Color(0xFFEFEFF4),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(16, 10, _right, 10),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
            child: Stack(
              children: <Widget>[
                Center(
                  child: TextField(
                    focusNode: _focusNode,
                    controller: _controller,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Color(0xFFB8B8B8), fontSize: 13),
                        contentPadding: EdgeInsets.fromLTRB(_left + 27, 5, 28, 5),
                        border: InputBorder.none,
                        hintText: hint),
                    style: TextStyle(color: Color(0xff333333), fontSize: 13),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: _left + 12),
                    child: ImageHelper.icon("ic_search", width: 12),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: _right - _cancelWidth,
            child: GestureDetector(
              onTap: () {
                _controller.text = "";
                _focusNode.unfocus();
              },
              child: Container(
                height: 48,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Center(
                  child: Text(
                    cancelText,
                    style: TextStyle(color: Color(0xFF3183FB), fontSize: 16),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
