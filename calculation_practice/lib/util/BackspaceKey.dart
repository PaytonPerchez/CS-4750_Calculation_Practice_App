import 'package:flutter/material.dart';

/// This class was adapted from the following article:
/// https://medium.com/flutter-community/custom-in-app-keboard-in-flutter-b925d56c8465
class BackspaceKey extends StatelessWidget {
  const BackspaceKey({Key? key,
    required this.onBackspace,
    this.flex = 1
  }) : super(key: key);

  final VoidCallback onBackspace;
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
                onBackspace.call();
              },
              child: Container(
                child: Center(
                  child: Icon(Icons.backspace),
                ),
              ),
            ),
          ),
        )
    );
  }
}
