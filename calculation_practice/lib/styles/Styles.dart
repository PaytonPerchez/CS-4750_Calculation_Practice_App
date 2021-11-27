import 'package:flutter/material.dart';
//import 'package:calculation_practice/styles/util.dart';

/// Adapted from:
/// https://medium.com/@srajas02/flutter-styling-tricks-3192907f56e3
class Styles {
  //static final String _modernLatinFont = 'Modern Latin';
  //static final String _gilroyFont = 'Gilroy';

  static final TextStyle headerStyles = TextStyle(
    fontSize: 30,
    decoration: TextDecoration.underline,
  );

  static final bodyStyle = TextStyle(
    fontSize: 20,
    color: Colors.black,
  );

  static final TextStyle buttonStyles = TextStyle(
    fontSize: 24,
  );

  static final TextStyle operatorStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle templateButtonStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}