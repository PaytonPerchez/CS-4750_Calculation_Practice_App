import 'package:flutter/material.dart';
import 'package:calculation_practice/misc_screens/general_template_screen.dart';
import 'package:calculation_practice/util/Preferences.dart';

class SubPage extends StatefulWidget {
  SubPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SubPageState createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: DefaultTextStyle(
        style: TextStyle(
            fontSize: 24,
            color: Colors.black
        ),
        child: GeneralScreen(
          operation: Text('-'),
          preview: Text('a\u2081 - ... - a\u2099'),
          attribute: Text('n terms'),
          values: Preferences('-'),
        ),
      ),
    );
  }
}
