import 'package:flutter/material.dart';
import 'package:calculation_practice/misc_screens/general_template_screen.dart';
import 'package:calculation_practice/util/Preferences.dart';
//import 'package:flutter_tex/flutter_tex.dart';

class MultPage extends StatefulWidget {
  MultPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MultPageState createState() => _MultPageState();
}

class _MultPageState extends State<MultPage> {

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
          operation: Text('\u00d7'),
          /*TeXView(
            child: TeXViewDocument(
                r"""$$\times$$<br> """,
            ),
          ),*/
          preview: Text('a\u2081 \u00d7 ... \u00d7 a\u2099'),
          /*TeXView(
            child: TeXViewDocument(
                r"""$$a_1 \times ... \times a_n$$<br> """,
            ),
          ),*/
          attribute: Text('n terms'),
          values: Preferences('*'),
        ),
      ),
    );
  }
}
