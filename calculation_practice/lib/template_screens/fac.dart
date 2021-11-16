import 'package:flutter/material.dart';
import 'package:calculation_practice/misc_screens/general_template_screen.dart';
import 'package:calculation_practice/util/Preferences.dart';
import 'package:flutter_tex/flutter_tex.dart';

class FacPage extends StatefulWidget {
  const FacPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _FacPageState createState() => _FacPageState();
}

class _FacPageState extends State<FacPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: DefaultTextStyle(
        style: TextStyle(
            fontSize: 20,
            color: Colors.black
        ),
        child: GeneralScreen(
          operation: Text('!'),
          preview: Text('a!'),
          attribute: Text(''),
          values: Preferences('!'),
        ),
      ),
    );
  }
}
