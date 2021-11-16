import 'package:flutter/material.dart';
import 'package:calculation_practice/misc_screens/general_template_screen.dart';
import 'package:calculation_practice/util/Preferences.dart';
//import 'package:flutter_tex/flutter_tex.dart';

class TrigPage extends StatefulWidget {
  const TrigPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TrigPageState createState() => _TrigPageState();
}

class _TrigPageState extends State<TrigPage> {

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
          operation: Text(''),
          preview: Text('sin\u207f(a)'),
          attribute: Text('n\u1d57\u02b0 power'),
          values: Preferences('sin'),
        ),
      ),
    );
  }
}
