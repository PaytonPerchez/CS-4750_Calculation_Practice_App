import 'package:flutter/material.dart';
import 'package:calculation_practice/misc_screens/general_template_screen.dart';
import 'package:calculation_practice/util/Preferences.dart';

class SumFacPage extends StatefulWidget {
  const SumFacPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SumFacPageState createState() => _SumFacPageState();
}

class _SumFacPageState extends State<SumFacPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GeneralScreen(
          operation1: Text('sum'),
          operation2: Text('!'),
          preview1: Text('sum from i to n ()'),
          preview2: Text('a!'),
          // TODO figure out specifics of summation variables
          attribute1: Text('n terms'),
          attribute2: Text('n terms'),
          values: Preferences(),
      ),
    );
  }
}
