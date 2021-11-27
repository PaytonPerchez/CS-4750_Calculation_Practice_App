import 'package:flutter/material.dart';
import 'package:calculation_practice/misc_screens/general_template_screen.dart';
import 'package:calculation_practice/util/Preferences.dart';
import 'package:calculation_practice/styles/Styles.dart';

class AddPage extends StatefulWidget {
  AddPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: DefaultTextStyle(
        style: Styles.bodyStyle,
        child: GeneralScreen(
          operation: Text('+'),
          preview: Text('a\u2081 + ... + a\u2099'),
          attribute: Text('n terms'),
          values: Preferences('+'),
        ),
      ),
    );
  }
}
