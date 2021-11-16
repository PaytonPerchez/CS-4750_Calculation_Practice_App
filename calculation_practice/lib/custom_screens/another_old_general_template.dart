import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:calculation_practice/util/Preferences.dart';
import 'package:calculation_practice/primary_screens/practice.dart';

//import 'package:flutter_tex/flutter_tex.dart';
/*_termsTxtFieldController.text = '$_n';
_termsTxtFieldController.selection = TextSelection.fromPosition(
  TextPosition(offset: _termsTxtFieldController.text.length)
);*/
enum operations { operation1, operation2 }

operations? _selectedOperation = operations.operation1;

class AnotherOldGeneralScreen extends StatefulWidget {
  const AnotherOldGeneralScreen(
      {Key? key,
        required this.operation1,
        required this.operation2,
        required this.preview1,
        required this.preview2,
        required this.attribute1,
        required this.attribute2,
        required this.values})
      : super(key: key);

  final Widget operation1;
  final Widget operation2;
  final Widget preview1;
  final Widget preview2;
  final Text attribute1;
  final Text attribute2;
  final Preferences values;

  @override
  _AnotherOldGeneralScreenState createState() => _AnotherOldGeneralScreenState();
}

class _AnotherOldGeneralScreenState extends State<AnotherOldGeneralScreen> {
  String _trigFunction = 'sin';
  Widget _preview = Text(''); // displays the format for a practice problem
  Text _attribute = Text(''); // indicates what the variables A and n do

  TextEditingController _minNController = new TextEditingController();
  TextEditingController _maxNController = new TextEditingController();
  TextEditingController _minAController = new TextEditingController();
  TextEditingController _maxAController = new TextEditingController();

  // TODO methods start here
  /// Changes the selected operation to the one specified, which changes the expression preview and attribute.
  /// * value: The operation specified.
  void _operationSelected(operations? value) {
    setState(() {
      _selectedOperation = value;

      // Get the String representation of the operation and store it in Preferences
      widget.values.setOperation(getOperationSelected());

      // Change _preview and _attribute to match the current operation
      switch (value) {
        case operations.operation1:
        // _preview has a special case when the current operation is a trigonometric function
          if (widget.attribute2.data.toString().compareTo('base n') == 0) {
            _preview = Text('$_trigFunction\u207f(a)');
            //_preview = TeXView(child: TeXViewDocument(r"""$$\""" + _trigFunction + r"""^{n}a$$<br> """,));
          } else {
            _preview = widget.preview1;
          }
          _attribute = widget.attribute1;

          break;

        case operations.operation2:
          _preview = widget.preview2;
          _attribute = widget.attribute2;

          break;

        default:
          break;
      }
    });
  }

  /// Determines what the next operation is.
  /// * Returns the String representation of the next operation.
  String getOperationSelected() {
    switch (widget.values.getOperation()) {
      case '+':
        return '-';
      case '-':
        return '+';
      case '*':
        return '/';
      case '/':
        return '*';
      case 'root':
        return '^';
      case '^':
        return 'root';
      case 'sin':
      case 'cos':
      case 'tan':
        return 'log';
      case 'log':
        return _trigFunction;
      case 'sum':
        return '!';
      case '!':
        return 'sum';
      case 'd/dx':
        return 'int';
      case 'int':
        return 'd/dx';
    // nPr
    // nCr
    // random
      default:
        return '';
    }
  }

  /// Sets the current trigonometric function to the specified value.
  /// * newValue: The specified value.
  void _setTrigFunction(String? newValue) {
    setState(() {
      _trigFunction = newValue!;
      widget.values.setOperation(_trigFunction);

      // Don't change the preview if a trig operation is not selected
      if (_selectedOperation == operations.operation1) {
        _preview = Text('$_trigFunction\u207f(a)');
      }
      //_preview = TeXView(child: TeXViewDocument(r"""$$\""" + _trigFunction + r"""^{n}a$$<br> """,));
    });
  }

  // TODO UI starts here
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
                Container(
                  height: 100,
                  width: 100,
                  child: Row(
                    children: <Widget>[
                      if (widget.attribute2.data
                          .toString()
                          .compareTo('base n') ==
                          0)
                        Flexible(
                          child: DropdownButton<String>(
                            value: _trigFunction,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (String? newValue) {
                              _setTrigFunction(newValue);
                            },
                            items: <String>['sin', 'cos', 'tan']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )
                      else
                        Flexible(child: widget.operation1),
                      Radio<operations>(
                        value: operations.operation1,
                        groupValue: _selectedOperation,
                        onChanged: _operationSelected,
                      ),
                    ],
                  ),
                ),
                // Operation 2
                Container(
                  height: 100,
                  width: 100,
                  child: Row(
                    children: <Widget>[
                      Flexible(child: widget.operation2),
                      Radio<operations>(
                        value: operations.operation2,
                        groupValue: _selectedOperation,
                        onChanged: _operationSelected,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Preview
          Flexible(
            child: _preview,
          ),
          // Attribute information
          _attribute,
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
                        // TODO consider checking for submission
                        onSubmitted: (String s) {
                          setState(() {
                            try {
                              // Do not change the text if unsuccessful
                              if (!widget.values.setMinN(int.parse(s))) {
                                _minNController.text =
                                    widget.values.getMinN().toString();
                              }
                            } on FormatException {
                              _minNController.text =
                                  widget.values.getMinN().toString();
                            }
                          });
                        },
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 100,
                      child: Text('\u2264 n \u2264'),
                      /*TeXView(
                        child: TeXViewDocument(
                            r"""$$\leq n \leq$$<br> """,
                        ),
                      ),*/
                    ),
                    // Maximum of n
                    Flexible(
                      child: TextField(
                        controller: _maxNController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        // TODO consider checking for submission
                        onSubmitted: (String s) {
                          setState(() {
                            try {
                              // Do not change the text if unsuccessful
                              if (!widget.values.setMaxN(int.parse(s))) {
                                _maxNController.text =
                                    widget.values.getMaxN().toString();
                              }
                            } on FormatException {
                              _maxNController.text =
                                  widget.values.getMaxN().toString();
                            }
                          });
                        },
                      ),
                    ),
                    // Randomize the range of n
                    ElevatedButton(
                      onPressed: () {
                        widget.values.randomizeRangeOfN();
                        setState(() {
                          _minNController.text =
                              widget.values.getMinN().toString();
                          _maxNController.text =
                              widget.values.getMaxN().toString();
                        });
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
                        // TODO consider checking for submission
                        onSubmitted: (String s) {
                          setState(() {
                            try {
                              // Do not change the text if unsuccessful
                              if (!widget.values.setMinA(int.parse(s))) {
                                _minAController.text =
                                    widget.values.getMinA().toString();
                              }
                            } on FormatException {
                              _minAController.text =
                                  widget.values.getMinA().toString();
                            }
                          });
                        },
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 100,
                      child: Text('\u2264 a \u2264'),
                      /*TeXView(
                        child: TeXViewDocument(
                            r"""$$\leq a \leq$$<br> """,
                        ),
                      ),*/
                    ),
                    // Maximum of a
                    Flexible(
                      child: TextField(
                        controller: _maxAController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        // TODO consider checking for submission
                        onSubmitted: (String s) {
                          setState(() {
                            try {
                              // Do not change the text if unsuccessful
                              if (!widget.values.setMaxA(int.parse(s))) {
                                _maxAController.text =
                                    widget.values.getMaxA().toString();
                              }
                            } on FormatException {
                              _maxAController.text =
                                  widget.values.getMaxA().toString();
                            }
                          });
                        },
                      ),
                    ),
                    // Randomize the range of a
                    ElevatedButton(
                      onPressed: () {
                        widget.values.randomizeRangeOfA();
                        setState(() {
                          _minAController.text =
                              widget.values.getMinA().toString();
                          _maxAController.text =
                              widget.values.getMaxA().toString();
                        });
                      },
                      child: Icon(Icons.casino),
                    ),
                  ],
                ),
                // Randomize All
                ElevatedButton(
                  onPressed: () {
                    widget.values.randomizeRangeOfN();
                    widget.values.randomizeRangeOfA();
                    setState(() {
                      _minNController.text = widget.values.getMinN().toString();
                      _maxNController.text = widget.values.getMaxN().toString();
                      _minAController.text = widget.values.getMinA().toString();
                      _maxAController.text = widget.values.getMaxA().toString();
                    });
                  },
                  child: const Text('Randomize All'),
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
              /*Flexible(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new PracticePage(
                                title: 'Practice', subject: widget)));
                  },
                  child: const ListTile(
                    title: const Text('Practice'),
                    trailing: Icon(Icons.navigate_next),
                  ),
                ),
              ),*/
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _selectedOperation = operations.operation1;

    _attribute = widget.attribute1;

    _minNController.text = widget.values.getMinN().toString();
    _maxNController.text = widget.values.getMaxN().toString();
    _minAController.text = widget.values.getMinA().toString();
    _maxAController.text = widget.values.getMaxA().toString();

    // Initialize a special case for _preview if the operation is trigonometric
    if (widget.values.getOperation().compareTo('sin') == 0) {
      _preview = Text('sin\u207f(a)');
      //_preview = TeXView(child: TeXViewDocument(r"""$$\sin^{n}a$$<br> """,));
    } else {
      _preview = widget.preview1;
    }
    super.initState();
  }
}