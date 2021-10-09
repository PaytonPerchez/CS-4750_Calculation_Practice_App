import 'package:flutter/material.dart';
import 'package:calculation_practice/misc_screens/general_template_screen.dart';

class RootPowPage extends StatefulWidget {
  RootPowPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _RootPowPageState createState() => _RootPowPageState();
}

class _RootPowPageState extends State<RootPowPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GeneralScreen(
          operation1: Text('root'),
          operation2: Text('^'),
          preview1: Text('a\u00b9/\u207f'),
          preview2: Text('a\u207f'),
          attribute1: Text('n\u1d57\u02b0 root'),
          attribute2: Text('n\u1d57\u02b0 power')
      ),
    );
  }
}
