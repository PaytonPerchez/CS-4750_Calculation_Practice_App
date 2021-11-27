import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:calculation_practice/util/Preferences.dart';
import 'package:calculation_practice/primary_screens/practice.dart';
import 'package:calculation_practice/styles/Styles.dart';

//import 'package:flutter_tex/flutter_tex.dart';
/*_termsTxtFieldController.text = '$_n';
_termsTxtFieldController.selection = TextSelection.fromPosition(
  TextPosition(offset: _termsTxtFieldController.text.length)
);*/
enum operations { sin, cos, tan }

operations? _selectedOperation = operations.sin;

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

  TextEditingController _minNController = new TextEditingController();
  TextEditingController _maxNController = new TextEditingController();
  TextEditingController _minAController = new TextEditingController();
  TextEditingController _maxAController = new TextEditingController();

  // TODO methods start here
  /// Sets the current trigonometric function to the specified value.
  /// * newValue: The specified value.
  void _setTrigFunction(operations? newValue) {
    setState(() {

      switch(newValue!) {
        case operations.sin:
          _selectedOperation = operations.sin;
          _trigFunction = 'sin';
          break;

        case operations.cos:
          _selectedOperation = operations.cos;
          _trigFunction = 'cos';
          break;

        case operations.tan:
          _selectedOperation = operations.tan;
          _trigFunction = 'tan';
          break;
      }

      widget.values.setOperation(_trigFunction);

      _preview = Text(
        '$_trigFunction\u207f(a)',
        style: Styles.bodyStyle,
      );
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

  /// Returns the controls for setting the range of n
  Widget _getRangeOfN() {
    return Row(
      children: [
        // Minimum of n
        Expanded(
          flex: 1,
          child: TextField(
            style: Styles.bodyStyle,
            controller: _minNController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
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
        Expanded(
          flex: 1,
          //height: 50,
          //width: 100,
          child: Center(
            child: Text(
              '\u2264 n \u2264',
              style: Styles.bodyStyle,
            ),
          ),
          /*TeXView(
                        child: TeXViewDocument(
                            r"""$$\leq n \leq$$<br> """,
                        ),
                      ),*/
        ),
        // Maximum of n
        Expanded(
          flex: 1,
          child: TextField(
            style: Styles.bodyStyle,
            controller: _maxNController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
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
        Expanded(
          flex: 1,
          child: ElevatedButton(
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
        ),
      ],
    );
  }


  Widget _genTrigOptions() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: RadioListTile<operations>(
            title: Text(
              'sin',
              style: Styles.bodyStyle,
            ),
            value: operations.sin,
            groupValue: _selectedOperation,
            onChanged: _setTrigFunction,
          ),
        ),
        Expanded(
          flex: 1,
          child: RadioListTile<operations>(
            title: Text(
              'cos',
              style: Styles.bodyStyle,
            ),
            value: operations.cos,
            groupValue: _selectedOperation,
            onChanged: _setTrigFunction,
          ),
        ),
        Expanded(
          flex: 1,
          child: RadioListTile<operations>(
            title: Text(
              'tan',
              style: Styles.bodyStyle,
            ),
            value: operations.tan,
            groupValue: _selectedOperation,
            onChanged: _setTrigFunction,
          ),
        ),
      ],
    );
  }

  // TODO UI starts here
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        alignment: Alignment(0.0, 0.0),

        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Operation
            if (_isTrigFunction())
              Expanded(
                flex: 1,
                child: _genTrigOptions(),
              ),
            Expanded(
              flex: 1,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Preview
                  Expanded(
                    flex: 1,
                    child: _preview,
                  ),
                  // Attribute information
                  Expanded(
                    flex: 1,
                    child: widget.attribute,
                  ),
                ],
              ),
            ),
            const Divider(
              height: 20,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            // Range Options
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  // Range of n
                  if(widget.values.getOperation().compareTo('!') != 0)
                    Expanded(
                      flex: 1,
                      child: _getRangeOfN(),
                    ),
                  // Range of a
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        // Minimum of a
                        Expanded(
                          flex: 1,
                          child: TextField(
                            style: Styles.bodyStyle,
                            controller: _minAController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
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
                        Expanded(
                          flex: 1,
                          //height: 50,
                          //width: 100,
                          child: Center(
                            child: Text(
                              '\u2264 a \u2264',
                              style: Styles.bodyStyle,
                            ),
                          ),
                          /*TeXView(
                            child: TeXViewDocument(
                                r"""$$\leq a \leq$$<br> """,
                            ),
                          ),*/
                        ),
                        // Maximum of a
                        Expanded(
                          flex: 1,
                          child: TextField(
                            style: Styles.bodyStyle,
                            controller: _maxAController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
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
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  // Randomize All
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
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
                  ),
                ],
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
                  // Practice Button
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) => new PracticePage(
                                    title: 'Practice', preferences: widget.values)));
                      },
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
    _selectedOperation = operations.sin;

    _minNController.text = widget.values.getMinN().toString();
    _maxNController.text = widget.values.getMaxN().toString();
    _minAController.text = widget.values.getMinA().toString();
    _maxAController.text = widget.values.getMaxA().toString();

    _preview = widget.preview;
    super.initState();
  }
}
