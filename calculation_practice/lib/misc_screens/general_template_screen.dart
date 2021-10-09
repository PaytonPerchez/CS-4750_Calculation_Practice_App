import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

enum operations {operation1, operation2}

operations? _selectedOperation = operations.operation1;

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({Key? key,
    required this.operation1,
    required this.operation2,
    required this.preview1,
    required this.preview2,
    required this.attribute1,
    required this.attribute2
  }) : super(key: key);

  final Widget operation1;
  final Widget operation2;
  final Text preview1;
  final Text preview2;
  final Text attribute1;
  final Text attribute2;

  @override
  _GeneralScreenState createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {

  Text _preview = Text('');
  Text _attribute = Text('');

  final int _MIN_N = 2;
  final int _MAX_N = 30;
  final int _MIN_A_VALUE = 0;
  final int _MAX_A_VALUE = 100;

  int _n = 0;
  int _minN = 0;
  int _maxN = 0;
  int _minA = 0;
  int _maxA = 0;

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
          _preview = widget.preview1;
          _attribute = widget.attribute1;
          break;
        case operations.operation2:
          _preview = widget.preview2;
          _attribute = widget.attribute2;
          break;
      }
    });
  }

  void _randomizeRangeOfN() {
    setState(() {
      // Ensure there are at least two terms
      _minN = Random.secure().nextInt(_MAX_N - _MIN_N) + _MIN_N;
      _maxN = Random.secure().nextInt(_MAX_N + 1);
      // Ensure _maxN > _minN
      if(_minN > _maxN){
        int range = _MAX_N - _minN;
        _maxN = _minN;
        _maxN += Random.secure().nextInt(range) + 1;
      }
      _minNController.text = '$_minN';
      _maxNController.text = '$_maxN';
    });
  }

  void _randomizeRangeOfA() {
    setState(() {
      _minA = Random.secure().nextInt(_MAX_A_VALUE);
      _maxA = Random.secure().nextInt(_MAX_A_VALUE);
      //Ensure _maxN > _minN
      if(_minA > _maxA){
        int range = _MAX_A_VALUE - _minA;
        _maxA = _minA;
        _maxA += Random.secure().nextInt(range) + 1;
      }
      _minAController.text = '$_minA';
      _maxAController.text = '$_maxA';
    });
  }

  void _randomizeN() {
    setState(() {
      _n = Random.secure().nextInt(_MAX_N) + 1;
      _termsTxtFieldController.text = '$_n';
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
                // Operation 1
                Row(
                  children: <Widget>[
                    widget.operation1,
                    Radio<operations>(
                      value: operations.operation1,
                      groupValue: _selectedOperation,
                      onChanged: _operationSelected,
                    ),
                  ],
                ),
                // Operation 2
                Row(
                  children: <Widget>[
                    widget.operation2,
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
          _preview,
          // Attribute information
          Row(
            children: <Widget>[
              // Number of terms
              _attribute,
              // Terms Randomizer
              ElevatedButton(
                onPressed: () {
                  _randomizeN();
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
                          } on FormatException {
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
                          } on FormatException {
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
                          } on FormatException {
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
                          } on FormatException {
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
                // Randomize All
                Row(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        _randomizeN();
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
    _preview = widget.preview1;
    _attribute = widget.attribute1;
    _n = _MIN_N;
    _minN = _MIN_N;
    _maxN = _MAX_N;
    _minA = _MIN_A_VALUE;
    _maxA = _MAX_A_VALUE;
    _minNController.text = '$_minN';
    _maxNController.text = '$_maxN';
    _minAController.text = '$_minA';
    _maxAController.text = '$_maxA';
  }

  Text generateExpression() {
    return Text('');
  }
}
