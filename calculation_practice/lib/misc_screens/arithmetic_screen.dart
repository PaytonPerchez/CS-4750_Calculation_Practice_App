import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

enum operations {operation1, operation2}

operations? _selectedOperation = operations.operation1;

class ArithmeticScreen extends StatefulWidget {
  const ArithmeticScreen({Key? key,
                          required this.operation1,
                          required this.operation2
                          }) : super(key: key);

  final String operation1;
  final String operation2;

  // final Row operationSelection;
  // final ? preview
  // final ? attribute

  @override
  _ArithmeticScreenState createState() => _ArithmeticScreenState();
}

class _ArithmeticScreenState extends State<ArithmeticScreen> {

  String _operationShown = '';


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
        case operations.operation1:
          _operationShown = widget.operation1;
          break;
        case operations.operation2:
          _operationShown = widget.operation2;
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

  void _randomizeNumOfTerms() {
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
    return Container(
      child: Column(
        children: <Widget>[
          // Main Settings
          Container(
            // Operations
            child: Row(
              children: <Widget>[
                // Addition
                Row(
                  children: <Widget>[
                    Text(widget.operation1),
                    Radio<operations>(
                      value: operations.operation1,
                      groupValue: _selectedOperation,
                      onChanged: _operationSelected,
                    ),
                  ],
                ),
                // Subtraction
                Row(
                  children: <Widget>[
                    Text(widget.operation2),
                    Radio<operations>(
                      value: operations.operation2,
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
              'a\u2081 ' + _operationShown + ' a\u2082 ' + _operationShown + ' a\u2083 '
                  + _operationShown + '...' + _operationShown + 'a\u2099'
          ),
          // Term information
          Row(
            children: <Widget>[
              // Number of terms
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
                  'terms'
              ),
              // Terms Randomizer
              ElevatedButton(
                onPressed: () {
                  _randomizeNumOfTerms();
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
                        _randomizeNumOfTerms();
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
    );
  }

  @override
  void initState() {
    super.initState();
    _operationShown = widget.operation1;
  }
}
