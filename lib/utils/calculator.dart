import 'd_stack.dart';

class Calculator {
  //计算器表达式项
  var expressionItems = [];

  String getCurrent() {
    var len = expressionItems.length;
    if (len == 0)
      return "";
    else
      return expressionItems[len - 1];
  }

  void addText(String text) {
    if (expressionItems.isEmpty && isOpt(text)) return;
    var current = getCurrent();
    if (current.isEmpty && !("C" == text || "<" == text || "00" == text)) {
      expressionItems.add(text);
      return;
    }
    switch (text) {
      case "1":
      case "2":
      case "3":
      case "4":
      case "5":
      case "6":
      case "7":
      case "8":
      case "9":
      case "0":
        if (isNumber(current)) {
          current += text;
          replaceLast(current);
        } else {
          expressionItems.add(text);
        }
        break;
      case ".":
        if (isInteger(current)) {
          current = "$current.";
          replaceLast(current);
        }
        break;
      case "00":
        if (isNumber(current)) {
          current += "00";
          replaceLast(current);
        }
        break;
      case "+":
      case "-":
      case "×":
      case "÷":
        if (isNumber(current)) {
          expressionItems.add(text);
        } else {
          replaceLast(text);
        }
        break;
      case "C":
        expressionItems.clear();
        break;
      case "<":
        deleteItem();
        break;
    }
  }

  static bool isNumber(String text) {
    RegExp number = RegExp(r"^[0-9\.]+$");
    return number.hasMatch(text);
  }

  static bool isInteger(String text) {
    RegExp number = RegExp(r"[0-9]+");
    return number.hasMatch(text) && !text.contains("\.");
  }

  void deleteItem() {
    var current = getCurrent();
    if (current.isEmpty) {
      return;
    }
    var deletedCurrent = current.substring(0, current.length - 1);
    expressionItems.removeLast();
    if (deletedCurrent.isNotEmpty) {
      expressionItems.add(deletedCurrent);
    }
  }

  /*
    表达式
   */
  String expressionText() {
    var str = "";
    expressionItems.forEach((e) {
      str += e;
    });
    return str;
  }

  void replaceLast(String current) {
    expressionItems.removeLast();
    expressionItems.add(current);
  }

  bool isCurrentOpt() {
    var current = getCurrent();
    return isOpt(current);
  }

  /*
    是否为操作符
   */
  bool isOpt(text) {
    return "+-×÷".contains(text);
  }

  void reset(String text) {
    if (text.isEmpty) return;
    expressionItems.clear();
    expressionItems.add(text);
  }

  String calculate() {
    DStack<double> numbers = DStack(30);
    DStack<String> opts = DStack(30);
    int i = 0;
    if (expressionItems.isEmpty) return "";
    if (expressionItems.length == 1) return expressionItems[0];
    var end = expressionItems.length;
    if (isCurrentOpt()) end -= 1;
    while (i < end || !opts.isEmpty) {
      String str;
      if (i < end) str = expressionItems[i];
      if (str != null && isNumber(str)) {
        numbers.push(double.parse(str));
        i++;
      } else if (str != null && (opts.isEmpty || level(str) > level(opts.top))) {
        opts.push(str);
        i++;
      } else {
        try {
          double right = numbers.pop();
          double left = numbers.pop();
          String opt = opts.top;
          if ("+" == opt) {
            numbers.push(left + right);
          } else if ("-" == opt) {
            numbers.push(left - right);
          } else if ("×" == opt) {
            numbers.push(left * right);
          } else if ("÷" == opt) {
            numbers.push(left / right);
          }
          opts.pop();
        } catch (e) {}
      }
    }
    double v = numbers.pop();
    if (v.toInt() == v) return "${v.toInt()}";
    return "$v";
  }

  int level(String str) {
    if ("×÷".contains(str)) {
      return 2;
    } else if ("+-".contains(str)) {
      return 1;
    } else {
      return 0;
    }
  }
}
