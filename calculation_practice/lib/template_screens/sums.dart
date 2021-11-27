import 'package:flutter/material.dart';
import 'package:calculation_practice/misc_screens/general_template_screen.dart';
import 'package:calculation_practice/util/Preferences.dart';
import 'package:calculation_practice/styles/Styles.dart';
import 'package:flutter_tex/flutter_tex.dart';

class SumPage extends StatefulWidget {
  const SumPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SumPageState createState() => _SumPageState();
}

class _SumPageState extends State<SumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: DefaultTextStyle(
        style: Styles.bodyStyle,
        child: GeneralScreen(
            operation: Text('\u2211'),
            /*TeXView(
              child: TeXViewDocument(
                  r"""$$\sum$$<br> """,
              ),
            ),*/
            preview: TeXView(
              child: TeXViewDocument(
                  r"""$$\sum_{i=a}^{n} i$$<br> """,//Text('\u2211 from i to n ()'),
              ),
              style: TeXViewStyle(
                backgroundColor: Colors.grey.shade50,
                fontStyle: TeXViewFontStyle(
                  fontSize: Styles.bodyStyle.fontSize!.toInt()
                ),
              ),
            ),
            attribute: Text(''),
            values: Preferences('sum'),
        ),
      ),
    );
  }
}
