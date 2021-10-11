import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
/*
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
*/
enum operations {operation1, operation2}

operations? _selectedOperation = operations.operation1;

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({Key? key,
    required this.operation1,
    required this.operation2,
    //required this.preview,
    required this.attribute1,
    required this.attribute2
  }) : super(key: key);

  final Widget operation1;
  final Widget operation2;
  //final Text preview;
  final String attribute1;
  final String attribute2;

  @override
  _GeneralScreenState createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {

  String _operationShown = '';
  List<String> subscripts =
  [
    //'\u2080',
    //'\u2081',
    '\u2082',
    '\u2083',
    '\u2084',
    '\u2085',
    '\u2086',
    '\u2087',
    '\u2088',
    '\u2089',
  ];
  List<String> superscripts =
  [
    '\u2070',
    '\u2071',
    '\u2072',
    '\u2073',
    '\u2074',
    '\u2075',
    '\u2076',
    '\u2077',
    '\u2078',
    '\u2079',
  ];

  TextField _attributeField = new TextField();
  String _preview = '';

  final int _MIN_NUM_OF_TERMS = 2;
  final int _MAX_NUM_OF_TERMS = 30;
  final int _MIN_A_VALUE = 0;
  final int _MAX_A_VALUE = 100;
  final int _MAX_NUM_OF_DIGITS = 3;

  // TODO Change to n
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

  void _getPreview(String attribute) {
    switch(attribute) {
      case 'terms':
        _preview = 'a\u2081 ' + _operationShown + ' a\u2082';
        for(int i = 2; i < _numOfTerms; i++) {
          _preview += ' ' + _operationShown + ' a' + subscripts[i];
          // TODO implement double digit subscripts up to MAX
        }
        break;

      case 'root':
        _preview = '(a)^$_numOfTerms';
        break;

      case 'power':

        switch(widget.attribute2.toString()) {
          case 'log':
            if(_selectedOperation == operations.operation1) {

            }else{

            }
            break;

          case 'int':
            if(_selectedOperation == operations.operation1) {

            }else{

            }
            break;
        }
        break;

      case 'base':

        break;
    }
  }
  void _operationSelected(operations? value) {
    setState(() {
      _selectedOperation = value;
      switch(value){
        case operations.operation1:
          _operationShown = widget.operation1.toString();
          break;
        case operations.operation2:
          _operationShown = widget.operation2.toString();
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
                    widget.operation1,
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
          // TODO
          //widget.preview,
          // Term information
          Row(
            children: <Widget>[
              // Number of terms
              if(widget.attribute2.compareTo('base') == 0) Text(widget.attribute2),
              Flexible(
                child: _attributeField,
              ),
              if(widget.attribute2.compareTo('base') != 0) Text(widget.attribute2),
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
    _operationShown = widget.operation1.toString();
    _attributeField = TextField(
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
    );
  }
}
