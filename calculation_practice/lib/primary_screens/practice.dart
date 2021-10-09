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
                child: TextButton(
                  onPressed: () {},
                  child: const ListTile(
                    title: const Text('Practice'),
                    trailing: Icon(Icons.navigate_next),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    //_expression = widget.subject;
    super.initState();
  }
}
