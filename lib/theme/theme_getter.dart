import 'package:flutter/material.dart';

class ThemeGetter {
  static bool isDarkTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
