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

class GeneralScreen extends StatefulWidget {
  const GeneralScreen(
      {Key? key,
      required this.operation,
      required this.preview,
      required this.attribute,
      required this.values})
      : super(key: key);

  final Widget operation;
  final Widget preview;
  final Text attribute;
  final Preferences values;

  @override
  _GeneralScreenState createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  String _trigFunction = 'sin';
  Widget _preview = Text(''); // displays the format for a practice problem
  TextStyle _textStyle = TextStyle(
    fontSize: 20,
    color: Colors.black,
  );

  TextEditingController _minNController = new TextEditingController();
  TextEditingController _maxNController = new TextEditingController();
  TextEditingController _minAController = new TextEditingController();
  TextEditingController _maxAController = new TextEditingController();

  // TODO methods start here
  /// Sets the current trigonometric function to the specified value.
  /// * newValue: The specified value.
  void _setTrigFunction(String? newValue) {
    setState(() {
      _trigFunction = newValue!;
      widget.values.setOperation(_trigFunction);

      // Don't change the preview if a trig operation is not selected
      if (_selectedOperation == operations.operation1) {
        _preview = Text(
          '$_trigFunction\u207f(a)',
          style: _textStyle,
        );
      }
      //_preview = TeXView(child: TeXViewDocument(r"""$$\""" + _trigFunction + r"""^{n}a$$<br> """,));
    });
  }

  /// Determines if the current operation is trigonometric.
  /// * Returns true if the current operation is trigonometric, false otherwise.
  bool _isTrigFunction() {
    switch (widget.values.getOperation()) {
      case 'sin':
      case 'cos':
      case 'tan':
        return true;
      default:
        return false;
    }
  }

  /// TODO write later
  Widget _getRangeOfN() {
    if(widget.values.getOperation().compareTo('!') != 0) {
      return Row(
        children: [
          // Minimum of n
          Flexible(
            child: TextField(
              style: _textStyle,
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
            child: Text(
              '\u2264 n \u2264',
              style: _textStyle,
            ),
            /*TeXView(
                        child: TeXViewDocument(
                            r"""$$\leq n \leq$$<br> """,
                        ),
                      ),*/
          ),
          // Maximum of n
          Flexible(
            child: TextField(
              style: _textStyle,
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
      );
    } else {
      return Text('');
    }
  }

  // TODO UI starts here
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          // Operation
          if (_isTrigFunction())
            Container(
              height: 100,
              width: 100,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: DropdownButton<String>(
                      value: _trigFunction,
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
                ],
              ),
            ),
          // Preview
          Flexible(
            child: _preview,
          ),
          // Attribute information
          widget.attribute,
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
                _getRangeOfN(),
                // Range of a
                Row(
                  children: [
                    // Minimum of a
                    Flexible(
                      child: TextField(
                        style: _textStyle,
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
                      child: Text(
                        '\u2264 a \u2264',
                        style: _textStyle,
                      ),
                      /*TeXView(
                        child: TeXViewDocument(
                            r"""$$\leq a \leq$$<br> """,
                        ),
                      ),*/
                    ),
                    // Maximum of a
                    Flexible(
                      child: TextField(
                        style: _textStyle,
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
                  child: const Text(
                    'Randomize All',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
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
              Flexible(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new PracticePage(
                                title: 'Practice', preferences: widget.values)));
                  },
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
    _selectedOperation = operations.operation1;

    _minNController.text = widget.values.getMinN().toString();
    _maxNController.text = widget.values.getMaxN().toString();
    _minAController.text = widget.values.getMinA().toString();
    _maxAController.text = widget.values.getMaxA().toString();

    _preview = widget.preview;
    super.initState();
  }
}
