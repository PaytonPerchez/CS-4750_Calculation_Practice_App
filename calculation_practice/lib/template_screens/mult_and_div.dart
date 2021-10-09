import 'package:flutter/material.dart';
//import 'package:calculation_practice/misc_screens/arithmetic_screen.dart';
import 'package:calculation_practice/misc_screens/general_template_screen.dart';

class MultDivPage extends StatefulWidget {
  MultDivPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MultDivPageState createState() => _MultDivPageState();
}

class _MultDivPageState extends State<MultDivPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GeneralScreen(
        operation1: Text('*'),
        operation2: Text('/'),
        preview1: Text('a\u2081 * ... * a\u2099'),
        preview2: Text('a\u2081 / ... / a\u2099'),
        attribute1: Text('n terms'),
        attribute2: Text('n terms'),
      ),
    );
  }
}
