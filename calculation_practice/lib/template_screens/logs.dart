import 'package:flutter/material.dart';
import 'package:calculation_practice/misc_screens/general_template_screen.dart';
import 'package:calculation_practice/util/Preferences.dart';
import 'package:calculation_practice/styles/Styles.dart';
//import 'package:flutter_tex/flutter_tex.dart';

class LogPage extends StatefulWidget {
  const LogPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: DefaultTextStyle(
        style: Styles.bodyStyle,
        child: GeneralScreen(
          operation: Text('log'),
          preview: Text('log\u2099(a)'),
          /*TeXView(
            child: TeXViewDocument(
                r"""$$\log_n{a}$$<br> """,
            ),
          ),*/
          attribute: Text('base n'),
          values: Preferences('log'),
        ),
      ),
    );
  }
}
