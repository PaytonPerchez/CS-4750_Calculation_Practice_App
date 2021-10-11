import 'package:flutter/material.dart';
import 'package:calculation_practice/misc_screens/general_template_screen.dart';
import 'package:calculation_practice/util/Preferences.dart';

class DerivIntPage extends StatefulWidget {
  const DerivIntPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _DerivIntPageState createState() => _DerivIntPageState();
}

class _DerivIntPageState extends State<DerivIntPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GeneralScreen(
          operation1: Text('d/dx'),
          operation2: Text('int'),
          preview1: Text('(d/dx)(ax\u207f)'),
          preview2: Text('int(ax\u207f)'),
          attribute1: Text('n\u1d57\u02b0 power'),
          attribute2: Text('n\u1d57\u02b0 power'),
          values: Preferences('d/dx'),
      ),
    );
  }
}
