import 'package:flutter/material.dart';
import 'package:calculation_practice/misc_screens/general_template_screen.dart';
import 'package:calculation_practice/util/Preferences.dart';
//import 'package:flutter_tex/flutter_tex.dart';

class DerivPage extends StatefulWidget {
  const DerivPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _DerivPageState createState() => _DerivPageState();
}

class _DerivPageState extends State<DerivPage> {
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
            operation: Text('d/dx'),
            /*TeXView(
              child: TeXViewDocument(
                  r"""$$\frac{d}{dx}$$<br> """,
              ),
            ),*/
            preview: Text('(d/dx)(ax\u207f)'),
            /*TeXView(
              child: TeXViewDocument(
                  r"""$$\frac{d}{dx} ax^n$$<br> """,
              ),
            ),*/
            attribute: Text('n\u1d57\u02b0 power'),
            values: Preferences('d/dx'),
        ),
      ),
    );
  }
}
