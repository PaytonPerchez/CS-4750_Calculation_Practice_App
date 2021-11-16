import 'dart:io';

import 'package:flutter/material.dart';
import 'package:calculation_practice/misc_screens/general_template_screen.dart';
import 'package:calculation_practice/util/Preferences.dart';
//import 'package:flutter_tex/flutter_tex.dart';

class IntPage extends StatefulWidget {
  const IntPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _IntPageState createState() => _IntPageState();
}

class _IntPageState extends State<IntPage> {
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
          operation: Text('\u222b'),
          /*TeXView(
              child: TeXViewDocument(
                  r"""$$\int$$<br> """,
              ),
            ),*/
          preview: Text('\u222b(ax\u207f)dx'),
          /*TeXView(
              child: TeXViewDocument(
                  r"""$$\int ax^n dx$$<br> """,
              ),
            ),*/
          attribute: Text('n\u1d57\u02b0 power'),
          values: Preferences('int'),
        ),
      ),
    );
  }
}
