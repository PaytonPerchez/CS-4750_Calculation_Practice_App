import 'package:flutter/material.dart';
import 'package:calculation_practice/misc_screens/general_template_screen.dart';
import 'dart:math';

class PracticePage extends StatefulWidget {
  const PracticePage({Key? key, required this.title, required this.subject}) : super(key: key);

  final String title;
  final GeneralScreen subject;

  @override
  _PracticePageState createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {

  Text _expression = Text('');
  Text _solution = Text('');
  TextField _textField = TextField();
  double _answer = 0;

  TextButton _nextOption = TextButton(
    onPressed: null,
    child: Text(''),
  );
  TextButton _checkAns = TextButton(
    onPressed: null,
    child: Text(''),
  );
  TextButton _practice = TextButton(
    onPressed: null,
    child: Text(''),
  );

  void _toggleNextButton() {
    if(_nextOption == _checkAns) {
      setState(() {
        _nextOption = _practice;
        _solution = Text('$_answer');
      });
    } else {
      _nextOption = _checkAns;
      _generateExpression(widget.subject.values.getOperation());
      _solution = Text('');
    }
  }

  void _generateExpression(String operation) {
    switch(operation) {
      case '+':
      case '-':
      case '*':
      case '/':
        _genInfix(operation);
        break;
      case 'root':
      case '^':
        _genPow(operation);
        break;
      case 'sin':
      case 'cos':
      case 'tan':
        _genTrig(operation);
        break;
      case 'log':
        _genLog();
        break;
      case 'sum':
        break;
      case '!':
        _genFactorial();
        break;
      case 'deriv':
        break;
      case 'int':
        break;
      //case 'nCr':
      //case 'nPr':
      //case 'random':
    }
  }

  void _genInfix(String operation) {

    String expression = '';

    int a = Random.secure().nextInt(
        widget.subject.values.getMaxA() -
        widget.subject.values.getMinA()
    ) + widget.subject.values.getMinA();

    _answer = (Random.secure().nextInt(
        widget.subject.values.getMaxA() -
        widget.subject.values.getMinA()
    ) + widget.subject.values.getMinA()).toDouble();

    widget.subject.values.randomizeN();

    switch(operation) {
      case '+':
        expression = '$a + $_answer';
        _answer += a;

        for(int i = 2; i < widget.subject.values.getN(); i++) {
          a = Random.secure().nextInt(
              widget.subject.values.getMaxA() -
                  widget.subject.values.getMinA()
          ) + widget.subject.values.getMinA();
          expression += ' + $a';
          _answer += a;
        }
        break;
      case '-':
        expression = '$a - $_answer';
        _answer -= a;

        for(int i = 2; i < widget.subject.values.getN(); i++) {
          a = Random.secure().nextInt(
              widget.subject.values.getMaxA() -
                  widget.subject.values.getMinA()
          ) + widget.subject.values.getMinA();
          expression += ' - $a';
          _answer -= a;
        }
        break;
      case '*':
        expression = '$a * $_answer';
        _answer *= a;

        for(int i = 2; i < widget.subject.values.getN(); i++) {
          a = Random.secure().nextInt(
              widget.subject.values.getMaxA() -
                  widget.subject.values.getMinA()
          ) + widget.subject.values.getMinA();
          expression += ' * $a';
          _answer *= a;
        }
        break;
      case '/':
        expression = '$a / $_answer';
        _answer /= a;

        for(int i = 2; i < widget.subject.values.getN(); i++) {
          a = Random.secure().nextInt(
              widget.subject.values.getMaxA() -
                  widget.subject.values.getMinA()
          ) + widget.subject.values.getMinA();
          expression += ' / $a';
          _answer /= a;
        }
        break;
    }
    _expression = Text(expression);
  }

  void _genPow(String operation) {

    int a = Random.secure().nextInt(
        widget.subject.values.getMaxA() -
            widget.subject.values.getMinA()
    ) + widget.subject.values.getMinA();

    widget.subject.values.randomizeN();

    if(operation.compareTo('root') == 0) {
      _answer = pow(a, 1.0/widget.subject.values.getN()).toDouble();
    } else {
      _answer = pow(a, widget.subject.values.getN()).toDouble();
    }

    _expression = Text('$a ^ ' + widget.subject.values.getN().toString());
  }

  void _genTrig(String operation) {
    // TODO
    switch(operation) {
      case 'sin':
        break;
      case 'cos':
        break;
      case 'tan':
        break;
    }
  }

  void _genLog() {
    // TODO
  }

  void _genFactorial() {

    int a = Random.secure().nextInt(
        widget.subject.values.getMaxA() -
        widget.subject.values.getMinA()
    ) + widget.subject.values.getMinA();

    int b = a;
    _answer = 1;
    while(b > 1) {
      _answer *= b;
      b--;
    }
    _expression = Text('$a!');
  }

  // TODO sum, deriv, int

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
          _solution,
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
    //_expression = widget.subject;
    _checkAns = TextButton(
      onPressed: _toggleNextButton,
      child: const ListTile(
        title: const Text('Check'),
        trailing: Icon(Icons.navigate_next),
      ),
    );
    _practice = TextButton(
      onPressed: _toggleNextButton,
      child: const ListTile(
        title: const Text('Practice'),
        trailing: Icon(Icons.navigate_next),
      ),
    );
    _generateExpression(widget.subject.values.getOperation());
    _nextOption = _checkAns;
    super.initState();
  }
}
