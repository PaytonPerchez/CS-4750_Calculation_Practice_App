import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

enum operations {root, power}

operations? _selectedOperation = operations.root;

class RootPowPage extends StatefulWidget {
  RootPowPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _RootPowPageState createState() => _RootPowPageState();
}

class _RootPowPageState extends State<RootPowPage> {
  String _operationShown = '(1/n)';
  String _operation = 'root';

  // TODO change to more appropriate names
  final int _MIN_NUM_OF_TERMS = 2;
  final int _MAX_NUM_OF_TERMS = 30;
  final int _MIN_A_VALUE = 0;
  final int _MAX_A_VALUE = 100;
  final int _MAX_NUM_OF_DIGITS = 3;

  int _numOfTerms = 2;
  int _minN = 2;
  int _maxN = 2;
  int _minA = 0;
  int _maxA = 99;
  int _numOfDigits = 2;

  TextEditingController _termsTxtFieldController = new TextEditingController();
  TextEditingController _minNController = new TextEditingController();
  TextEditingController _maxNController = new TextEditingController();
  TextEditingController _minAController = new TextEditingController();
  TextEditingController _maxAController = new TextEditingController();

  void _operationSelected(operations? value) {
    setState(() {
      _selectedOperation = value;
      switch(value){
        case operations.root:
          _operationShown = '(1/n)';
          _operation = 'root';
          break;
        case operations.power:
          _operationShown = 'n';
          _operation = 'power';
          break;
      }
    });
  }

  void _randomizeRangeOfN() {
    setState(() {
      // Ensure there are at least two terms
      _minN = Random.secure().nextInt(_MAX_NUM_OF_TERMS - _MIN_NUM_OF_TERMS) + _MIN_NUM_OF_TERMS;
      _maxN = Random.secure().nextInt(_MAX_NUM_OF_TERMS + 1);
      // Ensure _maxN > _minN
      if(_minN > _maxN){
        int range = _MAX_NUM_OF_TERMS - _minN;
        _maxN = _minN;
        _maxN += Random.secure().nextInt(range) + 1;
      }
      _minNController.text = '$_minN';
      _maxNController.text = '$_maxN';
    });
  }

  void _randomizeRangeOfA() {
    setState(() {
      // TODO determine whether you should really add a digits option
      _minA = Random.secure().nextInt(pow(10, (_MAX_NUM_OF_DIGITS - 1)).round());
      _maxA = Random.secure().nextInt(pow(10, (_MAX_NUM_OF_DIGITS - 1)).round());
      //Ensure _maxN > _minN
      if(_minA > _maxA){
        int range = pow(10, (_MAX_NUM_OF_DIGITS - 1)).round() - _minA;
        _maxA = _minA;
        _maxA += Random.secure().nextInt(range) + 1;
      }
      _minAController.text = '$_minA';
      _maxAController.text = '$_maxA';
    });
  }

  void _setNumOfTerms(int value) {
    setState(() {
      if(value >= 2){
        _numOfTerms = value;
      }else{
        _termsTxtFieldController.text = '$_numOfTerms';
      }
    });
  }

  void _randomizePower() {
    setState(() {
      _numOfTerms = Random.secure().nextInt(_MAX_NUM_OF_TERMS) + 1;
      _termsTxtFieldController.text = '$_numOfTerms';
      _termsTxtFieldController.selection = TextSelection.fromPosition(
          TextPosition(offset: _termsTxtFieldController.text.length)
      );
    });
  }

  void _setMinN(int value) {
    setState(() {
      // Don't let users enter a greater min than max
      if(value < _maxN){
        _minN = value;
      }else{
        _minNController.text = '$_minN';
      }
    });
  }

  void _setMaxN(int value) {
    setState(() {
      // Don't let users enter a smaller max than min
      if(value > _minN){
        _maxN = value;
      }else{
        _maxNController.text = '$_maxN';
      }
    });
  }

  void _setMinA(int value) {
    setState(() {
      // Don't let users enter a greater min than max
      if(value < _maxA){
        _minA = value;
      }else{
        _minAController.text = '$_minA';
      }
    });
  }

  void _setMaxA(int value) {
    setState(() {
      // Don't let users enter a smaller max than min
      if(value > _minA){
        _maxA = value;
      }else{
        _maxAController.text = '$_maxA';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            // Main Settings
            Container(
              // Operations
              child: Row(
                children: <Widget>[
                  // Root
                  Row(
                    children: <Widget>[
                      Text('root'),
                      Radio<operations>(
                        value: operations.root,
                        groupValue: _selectedOperation,
                        onChanged: _operationSelected,
                      ),
                    ],
                  ),
                  // Power
                  Row(
                    children: <Widget>[
                      Text('^'),
                      Radio<operations>(
                        value: operations.power,
                        groupValue: _selectedOperation,
                        onChanged: _operationSelected,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Preview
            Text(
                '(a)^$_operationShown'
            ),
            // Power information
            Row(
              children: <Widget>[
                // Value of power
                Flexible(
                  child: TextField(
                    controller: _termsTxtFieldController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    onSubmitted: (String s) {
                      try{
                        _setNumOfTerms(int.parse(s));
                      }on FormatException catch(e){
                        _termsTxtFieldController.text = '$_numOfTerms';
                      }
                    },
                  ),
                ),
                Text(
                    '$_operation'
                ),
                // Power Randomizer
                ElevatedButton(
                  onPressed: () {
                    _randomizePower();
                  },
                  child: const Text('Random'),
                ),
              ],
            ),
            const Divider(
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 20,
            ),
            // Range Options
            Container(
              child: Column(
                children: [
                  // Range of n
                  Row(
                    children: [
                      // Minimum of n
                      Flexible(
                        child: TextField(
                          controller: _minNController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          onSubmitted: (String s) {
                            try {
                              _setMinN(int.parse(s));
                            } on FormatException catch (e) {
                              _minNController.text = '$_minN';
                            }
                          },
                        ),
                      ),
                      Text('<= n <='),
                      // Maximum of n
                      Flexible(
                        child: TextField(
                          controller: _maxNController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          onSubmitted: (String s) {
                            try {
                              _setMaxN(int.parse(s));
                            } on FormatException catch (e) {
                              _maxNController.text = '$_maxN';
                            }
                          },
                        ),
                      ),
                      // Randomize the range of n
                      ElevatedButton(
                        onPressed: () {
                          _randomizeRangeOfN();
                        },
                        child: Icon(Icons.casino),
                      ),
                    ],
                  ),
                  // Range of a
                  Row(
                    children: [
                      // Minimum of a
                      Flexible(
                        child: TextField(
                          controller: _minAController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          onSubmitted: (String s) {
                            try {
                              _setMinA(int.parse(s));
                            } on FormatException catch (e) {
                              _minAController.text = '$_minA';
                            }
                          },
                        ),
                      ),
                      Text('<= a <='),
                      // Maximum of a
                      Flexible(
                        child: TextField(
                          controller: _maxAController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          onSubmitted: (String s) {
                            try {
                              _setMaxA(int.parse(s));
                            } on FormatException catch (e) {
                              _maxAController.text = '$_maxA';
                            }
                          },
                        ),
                      ),
                      // Randomize the range of a
                      ElevatedButton(
                        onPressed: () {
                          _randomizeRangeOfA();
                        },
                        child: Icon(Icons.casino),
                      ),
                    ],
                  ),
                  // TODO Consider a number of digits option
                  // Randomize All
                  Row(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          _randomizePower();
                          _randomizeRangeOfN();
                          _randomizeRangeOfA();
                        },
                        child: const Text('Randomize All'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Navigation Buttons
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
      ),
    );
  }
}
