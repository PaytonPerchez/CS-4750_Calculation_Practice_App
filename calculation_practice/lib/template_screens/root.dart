import 'package:flutter/material.dart';
import 'package:calculation_practice/misc_screens/general_template_screen.dart';
import 'package:calculation_practice/util/Preferences.dart';
import 'package:calculation_practice/styles/Styles.dart';
//import 'package:flutter_tex/flutter_tex.dart';

class RootPage extends StatefulWidget {
  RootPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: DefaultTextStyle(
        style: Styles.bodyStyle,
        child: GeneralScreen(
            operation: Text('\u221a'),
            /*TeXView(
              child: TeXViewDocument(
                  r"""$$\sqrt{}$$<br> """,
              ),
            ),*/
            preview: Text('\u207f\u221aa'),
            /*TeXView(
              child: TeXViewDocument(
                  r"""$$\sqrt[n]{a}$$<br> """,
              ),
            ),*/
            attribute: Text('n\u1d57\u02b0 root'),
            values: Preferences('root'),
        ),
      ),
    );
  }
}
