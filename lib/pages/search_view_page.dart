import 'package:flutter/material.dart';
import '../widget/search_view.dart';

class SearchViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchViewPageState();
  }
}

class _SearchViewPageState extends State<SearchViewPage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String name = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: SearchView(
          controller: _controller,
          hint: "请输入关键词",
        ),
      ),
    );
  }
}
