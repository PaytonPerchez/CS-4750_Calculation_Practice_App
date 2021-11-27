import 'package:calculation_practice/util/Preferences.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:calculation_practice/styles/Styles.dart';
import 'package:flutter_tex/flutter_tex.dart';

enum nextOptions {check, practice}

nextOptions? _selectedOption = nextOptions.check;

class PracticePage extends StatefulWidget {
  const PracticePage({Key? key, required this.title, required this.preferences}) : super(key: key);

  final String title;
  final Preferences preferences;

  @override
  _PracticePageState createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {

  Widget _expression = Text('');
  Widget _displayedSolution = Text('');
  Text _prompt1 = Text(''); // prompt for derivatives and integrals
  Text _prompt2 = Text(''); // prompt for derivatives and integrals
  TextField _userAnswer1 = TextField(); // primary text field
  TextField _userAnswer2 = TextField(); // only used for derivatives and integrals
  TextEditingController _textFieldController1 = TextEditingController(); // controls primary text field
  TextEditingController _textFieldController2 = TextEditingController(); // controls secondary text field

  // status is true if the user's answer is correct, false if the answer
  // is incorrect, and blank while the user is solving the problem
  Text _status = Text('');

  double _answer1 = 0; // primary numerical answer
  double _answer2 = 0; // only used for derivatives and integrals
  Widget _symbolicAnswer = Text(''); // used when the answer is not numerical

  // next option is either _checkAns or _practice
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
  /// Switches between the practice and check answer states.
  void _toggleNextButton() {

    setState(() {

      // If checking the answer, display the answer and change the next option to practice
      if(_selectedOption == nextOptions.check) {

        _selectedOption = nextOptions.practice;
        _nextOption = _practice;

        // If the operation is not numerical, display a symbolic answer
        if((widget.preferences.getOperation().compareTo('d/dx') == 0) ||
            (widget.preferences.getOperation().compareTo('int') == 0)) {

          _displayedSolution = _symbolicAnswer;

        } else {
          _displayedSolution = Text('$_answer1', style: Styles.bodyStyle,);
        }

        _checkAnswer();

      // If practicing, generate a new expression and clear the displayed solution
      } else {

        _selectedOption = nextOptions.check;
        _nextOption = _checkAns;
        _generateExpression(widget.preferences.getOperation());
        _displayedSolution = Text('');
        _status = Text('');
        _textFieldController1.text = '';
        _textFieldController2.text = '';
      }
    });
  }

  /// Checks whether the user's answer is correct or not.
  /// * Returns true if the user's answer is correct, false otherwise.
  bool _checkAnswer() {

    // If the operation is either an integral or differential, then check both text fields
    if((widget.preferences.getOperation().compareTo('d/dx') == 0) ||
        (widget.preferences.getOperation().compareTo('int') == 0)) {

      try {

        if((double.parse(_textFieldController1.text) == _answer1) &&
            (double.parse(_textFieldController2.text) == _answer2)) {

          _status = Text(
            'Correct!',
            style: Styles.bodyStyle,
          );
          return true;

        } else {
          _status = Text(
            'Incorrect',
            style: Styles.bodyStyle,
          );
          return false;
        }

      } on FormatException {
        print('Format Exception occurred\n');
        return false;
      }

    // If the operation is numerical, compare the user's answer to _answer1
    } else {

      try {

        if(double.parse(_textFieldController1.text) == _answer1) {
          _status = Text(
            'Correct!',
            style: Styles.bodyStyle,
          );
          return true;
        } else {
          _status = Text(
            'Incorrect',
            style: Styles.bodyStyle,
          );
          return false;
        }

      } on FormatException {
        print('Format Exception occurred\n');
        return false;
      }
    }
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
        _genSum();
        break;
      case '!':
        _genFactorial();
        break;
      case 'd/dx':
        _genDifferential();
        break;
      case 'int':
        _genIntegral();
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
    int num = widget.preferences.generateConstant();

    // Generate a random constant
    _answer1 = widget.preferences.generateConstant().toDouble();

    // Randomize the number of terms
    widget.preferences.randomizeN();

    expression = '$num';

    switch(operation) {
      case '+':
        // Initialize the expression and answer with two terms
        expression += ' + ' + _answer1.toInt().toString();
        _answer1 += num;
        break;

      case '-':
        // Initialize the expression and answer with two terms
        expression += ' \u2212 ' + _answer1.toInt().toString();
        _answer1 = num - _answer1;
        break;

      case '*':
        // Initialize the expression and answer with two terms
        expression += ' \u00d7 ' + _answer1.toInt().toString();
        _answer1 = num * _answer1;
        break;

      case '/':
        // Initialize the expression and answer with two terms
        expression += ' \u00f7 ' + _answer1.toInt().toString();
        _answer1 = num / _answer1;
        break;
    }
    expression += _genTerms(operation);
    _expression = Text(
      expression,
      style: Styles.bodyStyle,
    );
  }

  /// Generates random terms to be operated on by the specified operation.
  /// * operation: The specified operation.
  /// * Returns an infix expression in String format.
  String _genTerms(String operation) {

    int num;
    String expression = "";
    String actualOperation;

    switch(operation) {
      case '-':
        actualOperation = '\u2212';
        break;
      case '*':
        actualOperation = '\u00d7';
        break;
      case '/':
        actualOperation = '\u00f7';
        break;
      default:
        actualOperation = operation;
        break;
    }

    // If there are more terms, append them to the expression and perform the specified operation on the
    // new term and current answer
    for(int i = 2; i < widget.preferences.getN(); i++) {

      // Generate a random constant
      num = widget.preferences.generateConstant();

      // Append the constant to the expression and perform operation
      switch(operation) {
        case '+':
          _answer1 += num;
          break;
        case '-':
          _answer1 -= num;
          break;
        case '*':
          _answer1 *= num;
          break;
        case '/':
          _answer1 /= num;
          break;
        default:
          break;
      }
      expression += ' $actualOperation $num';
    }
    return expression;
  }

  /// Generates an exponent expression based on the subject's preferences and the specified operation.
  /// * operation: The specified operation.
  void _genPow(String operation) {

    // Generate a random base
    int base = widget.preferences.generateConstant();

    // Randomize the exponent
    widget.preferences.randomizeN();

    // Perform the appropriate operation
    if(operation.compareTo('root') == 0) {

      // Get the correct root
      _answer1 = pow(base, 1.0/widget.preferences.getN()).toDouble();

      // Display a root expression
      _expression = TeXView(
        child: TeXViewDocument(
          r"""$$\sqrt[""" + widget.preferences.getN().toString() + r"""]{""" + base.toString() + r"""}$$<br> """,
        ),
        style: TeXViewStyle(
          backgroundColor: Colors.grey.shade50,
          fontStyle: TeXViewFontStyle(
              fontSize: Styles.bodyStyle.fontSize!.toInt()
          ),
        ),
      );
    } else {

      // Get the correct product
      _answer1 = pow(base, widget.preferences.getN()).toDouble();

      // Display an exponent expression
      _expression = TeXView(
        child: TeXViewDocument(
          r"""$$""" + base.toString() + r"""^{""" + widget.preferences.getN().toString() + r"""}$$<br> """,
        ),
        style: TeXViewStyle(
          backgroundColor: Colors.grey.shade50,
          fontStyle: TeXViewFontStyle(
              fontSize: Styles.bodyStyle.fontSize!.toInt()
          ),
        ),
      );
    }
  }

  /// Generates a trigonometric expression based on the subject's preferences and the specified operation.
  /// * operation: The specified operation.
  void _genTrig(String operation) {

    // TODO beware, the answer is in radians not degrees

    // Generate a random constant
    int theta = widget.preferences.generateConstant();

    // Randomize the exponent
    widget.preferences.randomizeN();

    // TODO should probably quantize theta as a multiple of pi
    // Perform the appropriate operation
    switch(operation) {
      case 'sin':
        _answer1 = pow(sin(theta), widget.preferences.getN()).toDouble();
        _expression = TeXView(
          child: TeXViewDocument(
            r"""$$\sin^{""" + widget.preferences.getN().toString() + r"""}(""" + theta.toString() + r""")$$<br> """,
          ),
          style: TeXViewStyle(
            backgroundColor: Colors.grey.shade50,
            fontStyle: TeXViewFontStyle(
                fontSize: Styles.bodyStyle.fontSize!.toInt()
            ),
          ),
        );
        break;
      case 'cos':
        _answer1 = pow(cos(theta), widget.preferences.getN()).toDouble();
        _expression = TeXView(
          child: TeXViewDocument(
            r"""$$\cos^{""" + widget.preferences.getN().toString() + r"""}(""" + theta.toString() + r""")$$<br> """,
          ),
          style: TeXViewStyle(
            backgroundColor: Colors.grey.shade50,
            fontStyle: TeXViewFontStyle(
                fontSize: Styles.bodyStyle.fontSize!.toInt()
            ),
          ),
        );
        break;
      case 'tan':
        _answer1 = pow(tan(theta), widget.preferences.getN()).toDouble();
        _expression = TeXView(
          child: TeXViewDocument(
            r"""$$\tan^{""" + widget.preferences.getN().toString() + r"""}(""" + theta.toString() + r""")$$<br> """,
          ),
          style: TeXViewStyle(
            backgroundColor: Colors.grey.shade50,
            fontStyle: TeXViewFontStyle(
                fontSize: Styles.bodyStyle.fontSize!.toInt()
            ),
          ),
        );
        break;
    }
  }

  /// Generates a logarithmic expression based on the subject's preferences.
  void _genLog() {

    // Generate a random constant
    int num = widget.preferences.generateConstant();

    // Randomize the base
    widget.preferences.randomizeN();

    // ln(a)/ln(b) = log_{b}(a)
    _answer1 = (log(num)/log(widget.preferences.getN()));

    _expression = TeXView(
      child: TeXViewDocument(
        r"""$$\log_{""" + widget.preferences.getN().toString() + r"""}""" + num.toString() + r"""$$<br> """,
      ),
      style: TeXViewStyle(
        backgroundColor: Colors.grey.shade50,
        fontStyle: TeXViewFontStyle(
            fontSize: Styles.bodyStyle.fontSize!.toInt()
        ),
      ),
    );
  }

  /// Generates a factorial expression based on the subject's preferences.
  void _genFactorial() {

    // Generate a random constant
    int num = widget.preferences.generateConstant();

    // Make a copy of the constant for decrementing
    int b = num;

    // Skip the last step of multiplying by 1
    _answer1 = 1;

    // Compute the factorial
    while(b > 1) {
      _answer1 *= b;
      b--;
    }
    _expression = Text(
      '$num!',
      style: Styles.bodyStyle,
    );
  }

  /// Generates a differential expression based on the subject's preferences.
  void _genDifferential() {

    // Generate a random coefficient
    int coefficient = widget.preferences.generateConstant();

    // Randomize the exponent
    widget.preferences.randomizeN();

    _expression = TeXView(
      child: TeXViewDocument(
        r"""$$\frac{d}{dx} (""" + coefficient.toString() + r"""x^{""" + widget.preferences.getN().toString() + r"""}) = ax^n$$<br> """,
      ),
      style: TeXViewStyle(
        backgroundColor: Colors.grey.shade50,
        fontStyle: TeXViewFontStyle(
            fontSize: Styles.bodyStyle.fontSize!.toInt()
        ),
      ),
    );

    // d/dx (ax^{n}) = (a*n)x^{n-1}
    _answer1 = (coefficient * widget.preferences.getN()).toDouble();
    _answer2 = (widget.preferences.getN() - 1).toDouble();

    _symbolicAnswer = TeXView(
      child: TeXViewDocument(
        r"""$$""" + _answer1.toString() + r"""x^{""" + _answer2.toString() + r"""}$$<br> """,
      ),
      style: TeXViewStyle(
        backgroundColor: Colors.grey.shade50,
        fontStyle: TeXViewFontStyle(
            fontSize: Styles.bodyStyle.fontSize!.toInt()
        ),
      ),
    );
  }

  /// Generates an integral expression based on the subject's preferences.
  void _genIntegral() {

    // Generate a random coefficient
    int coefficient = widget.preferences.generateConstant();

    // Randomize the exponent
    widget.preferences.randomizeN();

    _expression = TeXView(
      child: TeXViewDocument(
        r"""$$\int (""" + coefficient.toString() + r"""x^{""" + widget.preferences.getN().toString() + r"""}) dx = ax^n + C$$<br> """,
      ),
      style: TeXViewStyle(
        backgroundColor: Colors.grey.shade50,
        fontStyle: TeXViewFontStyle(
            fontSize: Styles.bodyStyle.fontSize!.toInt()
        ),
      ),
    );

    // int (ax^{n}) = (a/(n+1))x^{n+1)
    _answer2 = (widget.preferences.getN() + 1).toDouble();
    _answer1 = coefficient.toDouble() / _answer2;

    _symbolicAnswer = TeXView(
      child: TeXViewDocument(
        r"""$$""" + _answer1.toString() + r"""x^{""" + _answer2.toString() + r"""} + C$$<br> """,
      ),
      style: TeXViewStyle(
        backgroundColor: Colors.grey.shade50,
        fontStyle: TeXViewFontStyle(
            fontSize: Styles.bodyStyle.fontSize!.toInt()
        ),
      ),
    );
  }

  /// Generates a summation expression based on the subject's preferences.
  void _genSum() {

    // Generate i
    int i = widget.preferences.generateConstant();

    // Randomize n
    widget.preferences.randomizeN();

    _expression = TeXView(
      child: TeXViewDocument(
        r"""$$\sum_{i=""" + i.toString() + r"""}^{""" + widget.preferences.getN().toString() + r"""} i$$<br> """,
      ),
    );

    _answer1 = 0;

    // Compute the sum
    for(int counter = i; counter <= widget.preferences.getN(); counter++) {
      _answer1 += counter;
    }
  }
  // nPr
  // nCr
  // random

  // TODO UI starts here
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          //Text('Practice'),
          _expression,
          _displayedSolution,
          _status,
          Container(
            //height: (MediaQuery.of(context).size.width) * 0.2,
            width: (MediaQuery.of(context).size.height) * 0.9,
            child: Row(
              children: [
                Expanded(flex: 1,child: _prompt1),
                Expanded(flex: 9,child: _userAnswer1),
              ],
            ),
          ),
          if((widget.preferences.getOperation().compareTo('d/dx') == 0) ||
              (widget.preferences.getOperation().compareTo('int') == 0))
            Container(
              width: (MediaQuery.of(context).size.height) * 0.9,
              child: Row(
                children: [
                  Expanded(flex: 1,child: _prompt2),
                  Expanded(flex: 9,child: _userAnswer2),
                ],
              ),
            ),
          Row(
            children: [
              // Back Button
              Flexible(
                child: TextButton(
                  onPressed: () {Navigator.pop(context);},
                  child: ListTile(
                    title: Text(
                      'Back',
                      style: Styles.bodyStyle,
                    ),
                    leading: Icon(
                      Icons.navigate_before,
                      size: (2.0 * Styles.bodyStyle.fontSize!.toInt()),
                    ),
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

    // Initialize prompts if the operation is ether integration or differentiation
    if((widget.preferences.getOperation().compareTo('d/dx') == 0) ||
        (widget.preferences.getOperation().compareTo('int') == 0)) {

      _prompt1 = Text('a = ', style: Styles.bodyStyle,);
      _prompt2 = Text('n = ', style: Styles.bodyStyle,);

    } else {
      _prompt1 = Text('');
      _prompt2 = Text('');
    }

    // Initialize functionality of next options
    _checkAns = TextButton(
      onPressed: _toggleNextButton,
      child: ListTile(
        title: Text(
          'Check',
          style: Styles.bodyStyle,
        ),
        trailing: Icon(
          Icons.navigate_next,
          size: (2.0 * Styles.bodyStyle.fontSize!.toInt()),
        ),
      ),
    );
    _practice = TextButton(
      onPressed: _toggleNextButton,
      child: ListTile(
        title: Text(
          'Practice',
          style: Styles.bodyStyle,
        ),
        trailing: Icon(
          Icons.navigate_next,
          size: (2.0 * Styles.bodyStyle.fontSize!.toInt()),
        ),
      ),
    );

    // Set controllers for text fields
    _userAnswer1 = TextField(
      controller: _textFieldController1,
      style: Styles.bodyStyle,
    );
    _userAnswer2 = TextField(
      controller: _textFieldController2,
      style: Styles.bodyStyle,
    );

    _generateExpression(widget.preferences.getOperation());
    _selectedOption = nextOptions.check;
    _nextOption = _checkAns;
    super.initState();
  }
}
