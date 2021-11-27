import 'package:flutter/material.dart';

/// Source: https://medium.com/@srajas02/flutter-styling-tricks-3192907f56e3
TextStyle extend(TextStyle s1, TextStyle s2) {
  return s1.merge(s2);
}