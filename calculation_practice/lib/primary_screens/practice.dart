import 'package:flutter/material.dart';
import 'package:calculation_practice/misc_screens/general_template_screen.dart';
import 'dart:math';

// TODO
/*
Only computes two terms when 2 <= n <= 3 for addition/subtraction
When exiting practicing, then immediately practicing again, the first check does not work
 */
enum nextOptions {check, practice}

nextOptions? _selectedOption = nextOptions.check;

class PracticePage extends StatefulWidget {
  const PracticePage({Key? key, required this.title, required this.subject}) : super(key: key);

  final String title;
  final GeneralScreen subject;

  @override
  _PracticePageState createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {

  Text _expression = Text('');
  Text _displayedSolution = Text('');
  TextField _userAnswer = TextField();
  TextEditingController _textFieldController = TextEditingController();
  Text _status = Text('');
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

  // TODO methods start here
  /// Switches the next button between practice and check answer buttons.
  void _toggleNextButton() {

    setState(() {

      // If checking the answer, display the answer and change the next option to practice
      if(_selectedOption == nextOptions.check) {

        _selectedOption = nextOptions.practice;
        _nextOption = _practice;
        _displayedSolution = Text('$_answer');

        try {
          if(double.parse(_textFieldController.text) == _answer) {
            _status = Text('Correct!');
          } else {
            _status = Text('Incorrect');
          }
          //print(double.parse(_textFieldController.text).toString() + '\n');
          //print(_answer.toString() + '\n');
        } on FormatException {print('uh oh\n');}

      // If practicing, generate a new expression and clear the displayed solution
      } else {

        _selectedOption = nextOptions.check;
        _nextOption = _checkAns;
        _generateExpression(widget.subject.values.getOperation());
        _displayedSolution = Text('');
        _status = Text('');
        _textFieldController.text = '';
      }
    });
  }

  /// Generates an expression based on the subject's preferences and the specified operation.
  /// * operation: The specified operation.
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

  /// Generates an infix expression based on the subject's preferences and the specified operation.
  /// * operation: The specified operation.
  void _genInfix(String operation) {

    String expression = '';

    // Generate a random constant
    int a = widget.subject.values.generateConstant();

    // Generate a random constant
    _answer = widget.subject.values.generateConstant().toDouble();

    // Randomize the number of terms
    widget.subject.values.randomizeN();

    switch(operation) {
      case '+':
        // Initialize the expression and answer with two terms
        expression = '$a + ' + _answer.toInt().toString();
        _answer += a;

        // If there are more terms, append them to the expression and answer
        for(int i = 2; i < widget.subject.values.getN(); i++) {

          // Generate a random constant
          a = widget.subject.values.generateConstant();

          // Append the constant to the expression and add it to the answer
          expression += ' + $a';
          _answer += a;
        }
        break;

      case '-':
        // Initialize the expression and answer with two terms
        expression = '$a - ' + _answer.toInt().toString();
        _answer = a - _answer;

        // If there are more terms, append them to the expression and subtract them from answer
        for(int i = 2; i < widget.subject.values.getN(); i++) {

          // Generate a random constant
          a = widget.subject.values.generateConstant();

          // Append the constant to the expression and subtract it from the answer
          expression += ' - $a';
          _answer -= a;
        }
        break;

      case '*':
        // Initialize the expression and answer with two terms
        expression = '$a * ' + _answer.toInt().toString();
        _answer = a * _answer;

        // If there are more terms, append them to the expression and multiply them to answer
        for(int i = 2; i < widget.subject.values.getN(); i++) {

          // Generate a random constant
          a = widget.subject.values.generateConstant();

          // Append the constant to the expression and multiply it to the answer
          expression += ' * $a';
          _answer *= a;
        }
        break;

      case '/':
        // Initialize the expression and answer with two terms
        expression = '$a / ' + _answer.toInt().toString();
        _answer = a / _answer;

        // If there are more terms, append them to the expression and divide them from answer
        for(int i = 2; i < widget.subject.values.getN(); i++) {

          // Generate a random constant
          a = widget.subject.values.generateConstant();

          // Append the constant to the expression and divide it from the answer
          expression += ' / $a';
          _answer /= a;
        }
        break;
    }
    _expression = Text(expression);
  }

  /// Generates an exponent expression based on the subject's preferences and the specified operation.
  /// * operation: The specified operation.
  void _genPow(String operation) {

    // Generate a random base
    int a = widget.subject.values.generateConstant();

    // Randomize the exponent
    widget.subject.values.randomizeN();

    // Perform the appropriate operation
    if(operation.compareTo('root') == 0) {
      _answer = pow(a, 1.0/widget.subject.values.getN()).toDouble();
      _expression = Text('$a ^ (1/' + widget.subject.values.getN().toString() + ')');
    } else {
      _answer = pow(a, widget.subject.values.getN()).toDouble();
      _expression = Text('$a ^ ' + widget.subject.values.getN().toString());
    }
  }

  /// Generates a trigonometric expression based on the subject's preferences and the specified operation.
  /// * operation: The specified operation.
  void _genTrig(String operation) {

    // Generate a random constant
    int a = widget.subject.values.generateConstant();

    // Randomize the exponent
    widget.subject.values.randomizeN();

    // TODO should probably quantize a as a multiple of pi
    // Perform the appropriate operation
    switch(operation) {
      case 'sin':
        _answer = pow(sin(a), widget.subject.values.getN()).toDouble();
        _expression = Text('sin^' + widget.subject.values.getN().toString() + '($a)');
        break;
      case 'cos':
        _answer = pow(cos(a), widget.subject.values.getN()).toDouble();
        _expression = Text('cos^' + widget.subject.values.getN().toString() + '($a)');
        break;
      case 'tan':
        _answer = pow(tan(a), widget.subject.values.getN()).toDouble();
        _expression = Text('tan^' + widget.subject.values.getN().toString() + '($a)');
        break;
    }
  }

  /// Generates a logarithmic expression based on the subject's preferences.
  void _genLog() {

    // Generate a random constant
    int a = widget.subject.values.generateConstant();

    // Randomize the base
    widget.subject.values.randomizeN();

    // ln(a)/ln(b) = log_{b}(a)
    _answer = (log(a)/log(widget.subject.values.getN()));

    _expression = Text('log_' + widget.subject.values.getN().toString() + '($a)');
  }

  /// Generates a factorial expression based on the subject's preferences.
  void _genFactorial() {

    // Generate a random constant
    int a = widget.subject.values.generateConstant();

    // Make a copy of the constant for decrementing
    int b = a;

    // Skip the last step of multiplying by 1
    _answer = 1;

    // Compute the factorial
    while(b > 1) {
      _answer *= b;
      b--;
    }

    _expression = Text('$a!');
  }

  // TODO sum, deriv, int

  // TODO UI starts here
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
          _displayedSolution,
          _status,
          _userAnswer,
          Row(
            children: [
              // TODO may not be necessary
              // Back Button
              Flexible(
                child: TextButton(
                  onPressed: () {Navigator.pop(context);},
                  child: const ListTile(
                    title: const Text('Back'),
                    leading: Icon(Icons.navigate_before),
                  ),
                ),
              ),
              // CheckAnswer/Practice Button
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
    _userAnswer = TextField(
      controller: _textFieldController,
    );
    _generateExpression(widget.subject.values.getOperation());
    _nextOption = _checkAns;
    super.initState();
  }
}
