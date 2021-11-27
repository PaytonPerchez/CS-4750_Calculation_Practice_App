import 'package:calculation_practice/primary_screens/practice.dart';
import 'package:calculation_practice/util/Preferences.dart';
import 'package:flutter/material.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _RandomPageState createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {

  List<Expanded> _checkBoxes = [];
  TextStyle _textStyle = TextStyle(
    fontSize: 20,
    color: Colors.black,
  );

  Expanded _buildRow(int flex, String operation) {
    bool? isChecked = false;

    return Expanded(
      flex: flex,
      child: CheckboxListTile(
        title: Text(
          operation,
          style: _textStyle,
        ),
        value: isChecked,
        onChanged: (newValue) {
          setState(() {
            isChecked = newValue;
          });
        },
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        child: Column(
          children: [
            // Row 1
            Expanded(
              flex: 2,
              child: Row(
                children: _checkBoxes.sublist(0, 3),
              ),
            ),
            // Row 2
            Expanded(
              flex: 2,
              child: Row(
                children: _checkBoxes.sublist(4, 7),
              ),
            ),
            // Row 3
            Expanded(
              flex: 2,
              child: Row(
                children: _checkBoxes.sublist(8, 11),
              ),
            ),
            // Navigation Buttons
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  // Back Button
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const ListTile(
                        title: const Text('Back'),
                        leading: Icon(Icons.navigate_before),
                      ),
                    ),
                  ),
                  // Practice Button
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context, // TODO parse _selected as well
                            new MaterialPageRoute(
                                builder: (BuildContext context) => new PracticePage(
                                    title: 'Practice', preferences: Preferences('random')
                                )
                            )
                        );
                      },
                      child: const ListTile(
                        title: const Text('Practice'),
                        trailing: Icon(Icons.navigate_next),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _checkBoxes = [
      _buildRow(1, '+'), _buildRow(1, '\u2212'), _buildRow(1, '\u00d7'), _buildRow(1, '\u00f7'),
      _buildRow(1, '\u221a'), _buildRow(1, '^'), _buildRow(1, 'trig'), _buildRow(1, 'log'),
      _buildRow(1, '\u2211'), _buildRow(1, '!'), _buildRow(1, 'd/dx'), _buildRow(1, '\u222b'),
    ];
    super.initState();
  }
}
