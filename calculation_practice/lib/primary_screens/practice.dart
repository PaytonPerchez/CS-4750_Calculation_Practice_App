import 'package:flutter/material.dart';
import 'package:calculation_practice/misc_screens/general_template_screen.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({Key? key, required this.title, required this.subject}) : super(key: key);

  final String title;
  final GeneralScreen subject;

  @override
  _PracticePageState createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  Text _expression = Text('');
  TextField _textField = TextField();
  TextButton _nextOption = TextButton(
    onPressed: null,
    child: Text(''),
  );
  TextButton _checkAns = TextButton(
    onPressed: () {},
    child: const ListTile(
      title: const Text('Check'),
      trailing: Icon(Icons.navigate_next),
    ),
  );
  TextButton _practice = TextButton(
    onPressed: () {},
    child: const ListTile(
      title: const Text('Practice'),
      trailing: Icon(Icons.navigate_next),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text('Practice'),
          _expression,
          _textField,
          Row(
            children: [
              // Back Button
              Flexible(
                child: TextButton(
                  onPressed: () {},
                  child: const ListTile(
                    title: const Text('Back'),
                    leading: Icon(Icons.navigate_before),
                  ),
                ),
              ),
              // Practice Button
              Flexible(
                child: _nextOption,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // form the expression
    //_expression = widget.subject;
    _nextOption = _checkAns;
    super.initState();
  }
}
