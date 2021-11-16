import 'package:flutter/material.dart';
import 'package:calculation_practice/misc_screens/general_template_screen.dart';
import 'package:calculation_practice/util/Preferences.dart';
//import 'package:flutter_tex/flutter_tex.dart';

class DivPage extends StatefulWidget {
  DivPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _DivPageState createState() => _DivPageState();
}

class _DivPageState extends State<DivPage> {

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
          operation: Text('\u00f7'),
          /*TeXView(
            child: TeXViewDocument(
                r"""$$\div$$<br> """,
            ),
          ),*/
          preview: Text('a\u2081 \u00f7 ... \u00f7 a\u2099'),
          /*TeXView(
            child: TeXViewDocument(
                r"""$$a_1 \div ... \div a_n$$<br> """,
            ),
          ),*/
          attribute: Text('n terms'),
          values: Preferences('/'),
        ),
      ),
    );
  }
}
