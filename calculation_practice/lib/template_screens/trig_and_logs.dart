import 'package:flutter/material.dart';
import 'package:calculation_practice/misc_screens/general_template_screen.dart';
import 'package:calculation_practice/util/Preferences.dart';

class TrigLogPage extends StatefulWidget {
  const TrigLogPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TrigLogPageState createState() => _TrigLogPageState();
}

class _TrigLogPageState extends State<TrigLogPage> {
  String _constant = 'sin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GeneralScreen(
          operation1: DropdownButton<String>(
            value: _constant,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            onChanged: (String? newValue) {
              setState(() {
                _constant = newValue!;
              });
            },
            items: <String>['sin', 'cos', 'tan']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          operation2: Text('log'),
          // TODO figure out how to change the preview for sin, cos, and tan
          preview1: Text('sin\u207f(a)'),
          preview2: Text('log\u2099(a)'),
          attribute1: Text('n\u1d57\u02b0 power'),
          attribute2: Text('base n'),
          values: Preferences(),
      ),
    );
  }
}
