import 'package:calculation_practice/util/BackspaceKey.dart';
import 'package:flutter/material.dart';
import 'package:calculation_practice/util/CustomKeyboard.dart';
import 'package:calculation_practice/styles/Styles.dart';

/// Parts of this class were adapted from the following article:
/// https://medium.com/flutter-community/custom-in-app-keboard-in-flutter-b925d56c8465
class CalculatorPage extends StatefulWidget {
  CalculatorPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  /* math_expressions format
     + = +
     - = -
     * = *
     / = /
     ( = (
     ) = )
     sin = sin
     cos = cos
     tan = tan
     ^ = ^
     root = nrt(nth, num) or sqrt(num)
     log = log(base, num) or ln(num)
     Missing: !, sum, d/dx, int
  */

  String _constant = 'pi';
  String _variable = 'x';
  TextEditingController _controller = TextEditingController();

  void _onBackspace() {
    String text = _controller.text;
    TextSelection selectedText = _controller.selection;
    int selectionLength = selectedText.end - selectedText.start;

    // There is a selection.
    if(selectionLength > 0) {
      // Delete the selection
      String newText = text.replaceRange(
        selectedText.start,
        selectedText.end,
        '',
      );
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: selectedText.baseOffset - selectionLength,
        ),
      );

    // The cursor is not at the beginning.
    } else if(selectedText.baseOffset > 0) {
      // Delete the previous character
      int newStart = selectedText.start - 1;
      int newEnd = selectedText.start;
      String newText = text.replaceRange(
        newStart,
        newEnd,
        '',
      );
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: selectedText.baseOffset - 1,
        ),
      );
    }
  }

  void _onTextInput(String input) {
    String text = _controller.text;
    TextSelection selectedText = _controller.selection;

    if(selectedText.baseOffset < 0) {
      _controller.text += input;
    } else {
      String newText = text.replaceRange(
        selectedText.start,
        selectedText.end,
        input,
      );

      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: selectedText.baseOffset + input.length,
        ),
      );
    }
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
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: TextField(
                      controller: _controller,
                      showCursor: true,
                      readOnly: true,
                      style: Styles.bodyStyle,
                    ),
                  ),
                  BackspaceKey(
                    flex: 1,
                    onBackspace: _onBackspace,
                  ),
                ],
              ),
            ),
          ),

          // Empty space between keyboard and text field
          SizedBox(
            height: 20,
          ),

          // Main buttons
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Operation buttons
                  Expanded(
                    flex: 1,
                    child: CustomKeyboard(
                      onTextInput: (input) {
                        _onTextInput(input);
                      },
                      buttons: [
                        ['+', '\u2212', '\u00d7', '\u00f7'],
                        ['\u221a', '^', '!'],
                        ['sin', 'cos', 'tan'],
                        ['log', 'ln', '\u2211'],
                        ['nCr', 'nPr'],
                      ],
                    ),
                  ),

                  SizedBox(
                    width: 12.0,
                  ),

                  // Number buttons
                  Expanded(
                    flex: 1,
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
                ],
              ),
            ),
          ),

          // Empty space between main buttons and bottom buttons
          SizedBox(
            height: 20,
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
                    style: Styles.operatorStyle,
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
