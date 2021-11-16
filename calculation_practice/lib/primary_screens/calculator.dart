import 'package:calculation_practice/util/BackspaceKey.dart';
import 'package:flutter/material.dart';
import 'package:calculation_practice/util/CustomKeyboard.dart';

/// Parts of this class were adapted from the following article:
/// https://medium.com/flutter-community/custom-in-app-keboard-in-flutter-b925d56c8465
class CalculatorPage extends StatefulWidget {
  CalculatorPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _constant = 'pi';
  String _variable = 'x';
  TextEditingController _controller = TextEditingController();
  TextStyle _textStyle = TextStyle(
    fontSize: 24,
    color: Colors.grey,
  );

  void _onBackspace() {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final selectionLength = textSelection.end - textSelection.start;

    // There is a selection.
    if(selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      _controller.text = newText;
      _controller.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start
      );
      return;
    }

    // The cursor is at the beginning.
    if(textSelection.start == 0) {
      return;
    }

    // Delete the previous character
    //final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }

  void _onTextInput(String input) {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      input,
    );
    final inputLength = input.length;
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + inputLength,
      extentOffset: textSelection.start + inputLength,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          // Expression preview and save button
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: TextField(
                    controller: _controller,
                    showCursor: true,
                    readOnly: true,
                    style: _textStyle,
                  ),
                ),
                BackspaceKey(
                  flex: 1,
                  onBackspace: _onBackspace,
                ),
              ],
            ),
          ),

          // Empty space between keyboard and text field
          Expanded(
            child: Text(''),
            flex: 1,
          ),

          // Main buttons
          Expanded(
            flex: 6,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Operation buttons
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomKeyboard(
                      onTextInput: (input) {
                        _onTextInput(input);
                      },
                      buttons: [
                        ['+', '-', '\u00d7', '\u00f7'],
                        ['\u221a', '^', '!'],
                        ['sin', 'cos', 'tan'],
                        ['log', 'ln', '\u2211'],
                        ['nCr', 'nPr'],
                      ],
                    ),
                  ),
                ),

                // Number buttons
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomKeyboard(
                      onTextInput: (input) {
                        _onTextInput(input);
                      },
                      buttons: [
                        ['1', '2', '3'],
                        ['4', '5', '6'],
                        ['7', '8', '9'],
                        ['0', '.', '(-)'],
                        ['(', ')', 'a'],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Empty space between main buttons and bottom buttons
          Expanded(
            child: Text(''),
            flex: 1,
          ),

          // Left, right, backspace, and equal buttons
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  child: Icon(Icons.west),
                  onPressed: null,
                ),
                OutlinedButton(
                  child: Icon(Icons.east),
                  onPressed: null,
                ),
                OutlinedButton(
                  child: Icon(Icons.save),
                  onPressed: null,
                ),
                OutlinedButton(
                  child: Text(
                    '=',
                    style: _textStyle,
                  ),
                  onPressed: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
