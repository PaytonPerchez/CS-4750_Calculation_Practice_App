import 'package:flutter/material.dart';

/// This class was adapted from the following article:
/// https://medium.com/flutter-community/custom-in-app-keboard-in-flutter-b925d56c8465
class TextKey extends StatelessWidget {
  const TextKey({Key? key,
    required this.text,
    required this.onTextInput,
    this.flex = 1
  }) : super(key: key);

  final String text;
  final ValueSetter<String> onTextInput;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Material(
            color: Colors.grey.shade200,
            child: InkWell(
              onTap: () {
                onTextInput.call(text);
              },
              child: Container(
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}
