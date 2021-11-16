import 'package:flutter/material.dart';
import 'package:calculation_practice/misc_screens/general_template_screen.dart';
import 'package:calculation_practice/util/Preferences.dart';
//import 'package:flutter_tex/flutter_tex.dart';

class PowPage extends StatefulWidget {
  PowPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _PowPageState createState() => _PowPageState();
}

class _PowPageState extends State<PowPage> {

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
          operation: Text('^'),
          preview: Text('a\u207f'),
          /*TeXView(
              child: TeXViewDocument(
                  r"""$$a^n$$<br> """,
              ),
          ),*/
          attribute: Text('n\u1d57\u02b0 power'),
          values: Preferences('^'),
        ),
      ),
    );
  }
}
