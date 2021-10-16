import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:calculation_practice/util/Preferences.dart';
import 'package:calculation_practice/primary_screens/practice.dart';
/*_termsTxtFieldController.text = '$_n';
_termsTxtFieldController.selection = TextSelection.fromPosition(
  TextPosition(offset: _termsTxtFieldController.text.length)
);*/
enum operations {operation1, operation2}

operations? _selectedOperation = operations.operation1;

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({Key? key,
    required this.operation1,
    required this.operation2,
    required this.preview1,
    required this.preview2,
    required this.attribute1,
    required this.attribute2,
    required this.values
  }) : super(key: key);

  final Widget operation1;
  final Widget operation2;
  final Text preview1;
  final Text preview2;
  final Text attribute1;
  final Text attribute2;
  final Preferences values;

  @override
  _GeneralScreenState createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {

  Text _preview = Text('');
  Text _attribute = Text('');

  TextEditingController _minNController = new TextEditingController();
  TextEditingController _maxNController = new TextEditingController();
  TextEditingController _minAController = new TextEditingController();
  TextEditingController _maxAController = new TextEditingController();

  // TODO methods start here
  /// Changes the selected operation to the one specified, which changes the expression preview and attribute.
  /// value: The operation specified.
  void _operationSelected(operations? value) {

    setState(() {

      _selectedOperation = value;

      switch(value){
        case operations.operation1:

          _preview = widget.preview1;
          _attribute = widget.attribute1;

          // Get the String representation of the operation and store it in Preferences
          widget.values.setOperation(getOperationSelected(value));
          break;

        case operations.operation2:

          _preview = widget.preview2;
          _attribute = widget.attribute2;

          // Get the String representation of the operation and store it in Preferences
          widget.values.setOperation(getOperationSelected(value));
          break;
      }
    });
  }

  /// Returns a String representation of the specified operation.
  /// value: The specified operation.
  String getOperationSelected(operations? value) {

    switch(widget.attribute1.data) {
      // (+, -), (*, /)
      case 'n terms':
        if(value == operations.operation1) {
          return (widget.operation1 as Text).data.toString();
        } else {
          return (widget.operation2 as Text).data.toString();
        }

      // Root, pow
      case 'n\u1d57\u02b0 root':
        if(value == operations.operation1) {
          return 'root';
        } else {
          return '^';
        }

      // (sin, cos, tan), (log), (deriv, int)
      case 'n\u1d57\u02b0 power':
        if(widget.attribute2.data!.compareTo('base n') == 0) {
          if(value == operations.operation1) {
            // TODO I have no idea if this will work
            return (widget.operation1 as DropdownButton).value.toString();
          } else {
            return 'log';
          }
        } else {
          if(value == operations.operation1) {
            return 'deriv';
          } else {
            return 'int';
          }
        }

      // sum, fac
      case '':
        if(value == operations.operation1) {
          return 'sum';
        } else {
          return '!';
        }

      // TODO nPr, nCr, random
      default:
        return '';
    }
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
          // TODO This row may be unnecessary
          Row(
            children: <Widget>[
              // Description of n
              _attribute,
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
                        // TODO consider checking for submission
                        onSubmitted: (String s) {
                          setState(() {
                            try {
                              // Do not change the text if unsuccessful
                              if (!widget.values.setMinN(int.parse(s))) {
                                _minNController.text = widget.values.getMinN().toString();
                              }
                            } on FormatException {
                              _minNController.text = widget.values.getMinN().toString();
                            }
                          });
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
                        // TODO consider checking for submission
                        onSubmitted: (String s) {
                          setState(() {
                            try {
                              // Do not change the text if unsuccessful
                              if (!widget.values.setMaxN(int.parse(s))) {
                                _maxNController.text = widget.values.getMaxN().toString();
                              }
                            } on FormatException {
                              _maxNController.text = widget.values.getMaxN().toString();
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
                          _minNController.text = widget.values.getMinN().toString();
                          _maxNController.text = widget.values.getMaxN().toString();
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
                              if(!widget.values.setMinA(int.parse(s))) {
                                _minAController.text = widget.values.getMinA().toString();
                              }
                            } on FormatException {
                              _minAController.text = widget.values.getMinA().toString();
                            }
                          });
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
                        // TODO consider checking for submission
                        onSubmitted: (String s) {
                          setState(() {
                            try {
                              // Do not change the text if unsuccessful
                              if(!widget.values.setMaxA(int.parse(s))) {
                                _maxAController.text = widget.values.getMaxA().toString();
                              }
                            } on FormatException {
                              _maxAController.text = widget.values.getMaxA().toString();
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
                          _minAController.text = widget.values.getMinA().toString();
                          _maxAController.text = widget.values.getMaxA().toString();
                        });
                      },
                      child: Icon(Icons.casino),
                    ),
                  ],
                ),
                // Randomize All
                // TODO row widget may be unnecessary
                Row(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        widget.values.randomizeN();
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
              ],
            ),
          ),
          // Navigation Buttons
          Row(
            children: [
              // Back Button
              // TODO may be unnecessary, therefore the row widget may be unnecessary as well
              Flexible(
                child: TextButton(
                  onPressed: () {Navigator.pop(context);},
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
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (BuildContext context) => new PracticePage(
                            title: 'Practice', subject: widget
                        )
                    ));
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
    super.initState();
    _preview = widget.preview1;
    _attribute = widget.attribute1;
    _minNController.text = widget.values.getMinN().toString();
    _maxNController.text = widget.values.getMaxN().toString();
    _minAController.text = widget.values.getMinA().toString();
    _maxAController.text = widget.values.getMaxA().toString();
  }
}