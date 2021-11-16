import 'package:flutter/material.dart';
import 'package:calculation_practice/util/TextKey.dart';

/// This class was adapted from the following article:
/// https://medium.com/flutter-community/custom-in-app-keboard-in-flutter-b925d56c8465
class CustomKeyboard extends StatelessWidget {
  const CustomKeyboard({Key? key,
    required this.buttons,
    required this.onTextInput
  }) : super(key: key);

  final List<List<String>> buttons;
  final ValueSetter<String> onTextInput;

  TextKey _buildTextKey(String text) {
    return TextKey(
      text: text,
      onTextInput: onTextInput,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> currentRow;
    List<Expanded> rows = [];

    for(int i = 0; i < buttons.length; i++) {

      List<Widget> actualRow = [];
      currentRow = buttons.elementAt(i);

      for(int j = 0; j < currentRow.length; j++) {
        actualRow.add(_buildTextKey(currentRow.elementAt(j)));
      }

      rows.add(Expanded(flex: 1, child: Row(children: actualRow)));
    }

    return Column(children: rows,);
  }
}
